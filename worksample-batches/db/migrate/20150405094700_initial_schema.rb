class InitialSchema < ActiveRecord::Migration
  def change
    create_table "addresses", :force => true do |t|
      t.string   "public_id"
      t.string   "mode"
      t.integer  "user_id"
      t.string   "name"
      t.string   "company"
      t.string   "email"
      t.string   "phone"
      t.string   "address_line_1"
      t.string   "address_line_2"
      t.string   "city"
      t.string   "state"
      t.string   "postal_code"
      t.string   "country"
      t.boolean  "residential"
      t.datetime "created_at",       :null => false
      t.datetime "updated_at",       :null => false
    end

    create_table "api_keys", :force => true do |t|
      t.string   "mode"
      t.integer  "user_id"
      t.string   "key"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    create_table "batches", :force => true do |t|
      t.string   "public_id"
      t.integer  "user_id"
      t.string   "mode"
      t.string   "state"
      t.string   "reference"
      t.datetime "created_at",                               :null => false
      t.datetime "updated_at",                               :null => false
    end

    create_table "parcels", :force => true do |t|
      t.string   "public_id"
      t.integer  "user_id"
      t.string   "mode"
      t.float    "length"
      t.float    "width"
      t.float    "height"
      t.float    "weight"
      t.string   "predefined_package"
      t.datetime "created_at",         :null => false
      t.datetime "updated_at",         :null => false
    end

    create_table "postage_labels", :force => true do |t|
      t.string   "public_id"
      t.integer  "user_id"
      t.string   "mode"
      t.integer  "rate_id"
      t.datetime "label_url"
      t.string   "label_width"
      t.string   "label_height"
      t.integer  "label_resolution"
      t.datetime "label_date"
      t.datetime "created_at",              :null => false
      t.datetime "updated_at",              :null => false
    end

    create_table "rates", :force => true do |t|
      t.string   "public_id"
      t.integer  "user_id"
      t.string   "mode"
      t.integer  "shipment_id"
      t.string   "carrier"
      t.string   "service"
      t.integer  "rate_cents"
      t.datetime "created_at",               :null => false
      t.datetime "updated_at",               :null => false
    end

    create_table "shipments", :force => true do |t|
      t.string   "public_id"
      t.integer  "user_id"
      t.string   "mode"
      t.integer  "to_address_id"
      t.integer  "from_address_id"
      t.integer  "parcel_id"
      t.integer  "selected_rate_id"
      t.integer  "postage_label_id"
      t.string   "tracking_code"
      t.string   "reference"
      t.text     "messages",              :limit => 2147483647
      t.datetime "created_at",                                                     :null => false
      t.datetime "updated_at",                                                     :null => false
    end

    create_table "users", :force => true do |t|
      t.string   "public_id"
      t.string   "name"
      t.string   "email"
      t.string   "password_digest"
      t.datetime "created_at",                                                              :null => false
      t.datetime "updated_at",                                                              :null => false
    end

  end
end

