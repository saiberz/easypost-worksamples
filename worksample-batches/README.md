EasyPost Work Sample - Batches
===============================

The goal of this sample is to add batch support to the basic API that is
provided.

There are two main uses for batches at EasyPost:

1. Some customers prefer to offload parallelization of a large number of tasks.

2. Many operations, such as creating an end of day shipping manifest, are
intrinsically meant for a group of shipments. Batches
provide a durable grouping of shipments for these types of operations.

The Batch model has been provided, but is missing most of its core functionality:

- There is currently no association between a Batch and its Shipments.

- The Batch includes a 'state' attribute that is set to 'creating' at creation,
but is not manipulated beyond that. You will have to build Batch objects into
proper state machines that transition appropriately between the states outlined
in the Batch model.

- Add controller methods, interactors, and jobs for adding and removing shipments
from a batch, creating shipments in a batch, buying the shipments in a batch,
and any other functionality you feel would be useful to a customer.
Make sure the state is coherently maintained throughout.

- Pay attention to the operation of buying shipments in a batch - how should
a customer indicate which rate they'd like to purchase for each individual
shipment?

Controller methods should have sane synchronous responses, and therefore should not
attempt to perform time consuming tasks like shipment creation (1s) or 
purchasing (2s) before responding. See the section below on using the provided
job queue to send tasks to the worker threads so that you can create and
purchase shipments asynchronously.

Don't get caught up attempting to reverse engineer EasyPost's current
API design from the client libraries and examples in the wild; our current
implementation is far from ideal!

Setup
------
On a fresh easypost-worksamples VM this sample should be
installed at /srv/worksample-batches. Before starting a Rails server or running
tests, double check that the gems in the Gemfile are installed and prepare the
database:

```bash
$ cd /srv/worksample-batches
$ gem install bundler
$ bundle install --path vendor/bundle
$ bundle exec foreman run rake db:migrate
$ bundle exec foreman run rake db:seed
$ bundle exec foreman run rake db:test:prepare
```

Note, this is a Rails 3.2 application running on Ruby 2.1.2.

Starting Rails Server
---------------------

```bash
$ bundle exec foreman start
```

Connecting to the server is simple from within the VM, it should simply be at:
http://localhost:5000. You can tets this by running:

```bash
$ curl http://localhost:5000/shipments -u 123456789:
```

On a fresh database the response should be: "[]".

If you setup the vagrant-hostmanager plugin you can also access the VM using the
hostname easypost-worksamples-vm, and the rails application at
http://easypost-worksamples-vm:5000/.

The public EasyPost client libraries should also be able to interact with this
application in a limited way (obviously only some of the endpoints are
implemented). Here's an example using the EasyPost Ruby gem:

```ruby
require 'easypost'
EasyPost.api_key = "123456789"
EasyPost.api_base = "http://easypost-worksamples-vm:5000/"

shipment = {
  from_address: { postal_code: 94105 },
  to_address: { postal_code: 90210 },
  parcel: { weight: 12.5 }
}

batch = EasyPost::Batch.create(shipments: [shipment])
p batch # state should be :creating
```


Running Tests
--------------

This sample does not come with many tests out of the box, however a well
rounded submission should include test coverage for the functionality that
you add.

```bash
$ bundle exec foreman run rspec spec
```

Beanstalk Job Queue
=====================

This sample includes the tools to interact with the Beanstalk job
queue that is installed on the VM. You will need to utilize worker threads which
pull jobs from Beanstalk in order to process large batches in a reasonable
amount of time.

Creating Jobs
--------------

Jobs are defined as classes in the EasyPost::Job module. Take a look at the
initial implementation of the BatchCreate job for an example.

To have Beanstalk create a queue for a given job, make sure it is listed in
the rake task which runs in each worker: lib/tasks/beanstalk.rake.

Running Jobs
----------------

Workers defined in the Procfile (you can edit the Procfile to add more workers)
will automatically pick up EasyPost::Jobs which
are flushed to Beanstalk. Pooled jobs will be flushed automatically at the end
of every controller request (see app/controllers/application_controller.rb for
the mechanism). Adding a job to the pool is simple:

```ruby
EasyPost::Job::JobClassName.pool(args)
```

The job's initialize method will be called with the args sent to pool. For
example, to call the example job from
app/controllers/batches_controller.rb#create:

```ruby
EasyPost::Job::BatchCreate.pool(params, @batch.id)
```


