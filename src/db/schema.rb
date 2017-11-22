# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 1) do

  create_table "channel_accesses", :force => true do |t|
    t.column "name", :string, :limit => 20, :default => "", :null => false
  end

  create_table "channel_categories", :force => true do |t|
    t.column "name", :string, :limit => 60, :default => "", :null => false
  end

  create_table "channel_favorites", :force => true do |t|
    t.column "channel_id", :integer, :default => 0, :null => false
    t.column "user_id",    :integer, :default => 0, :null => false
  end

  add_index "channel_favorites", ["channel_id"], :name => "channel_id"
  add_index "channel_favorites", ["user_id"], :name => "user_id"
  add_index "channel_favorites", ["channel_id", "user_id"], :name => "channel_and_user"

  create_table "channel_flags", :force => true do |t|
    t.column "created_at", :datetime,                 :null => false
    t.column "user_id",    :integer,  :default => 0,  :null => false
    t.column "channel_id", :integer,  :default => 0,  :null => false
    t.column "reason",     :string,   :default => "", :null => false
  end

  add_index "channel_flags", ["created_at", "channel_id"], :name => "created_at_and_channel"
  add_index "channel_flags", ["channel_id"], :name => "channel_id"

  create_table "channel_member_roles", :force => true do |t|
    t.column "name", :string, :limit => 20, :default => "", :null => false
  end

  create_table "channel_members", :force => true do |t|
    t.column "channel_id",             :integer,               :default => 0,     :null => false
    t.column "user_id",                :integer,               :default => 0,     :null => false
    t.column "channel_member_role_id", :integer,  :limit => 4, :default => 0,     :null => false
    t.column "currently_in",           :boolean,               :default => false, :null => false
    t.column "last_seen",              :datetime
  end

  add_index "channel_members", ["channel_id"], :name => "channel_id"
  add_index "channel_members", ["channel_id", "user_id"], :name => "channel_and_user"
  add_index "channel_members", ["channel_id", "currently_in"], :name => "channel_and_currently_in"
  add_index "channel_members", ["channel_id", "channel_member_role_id"], :name => "channel_and_channel_member_role"
  add_index "channel_members", ["channel_id", "currently_in", "channel_member_role_id"], :name => "channel_and_currently_in_and_channel_member_role"
  add_index "channel_members", ["user_id", "currently_in"], :name => "user_and_currently_in"
  add_index "channel_members", ["channel_member_role_id", "currently_in"], :name => "channel_member_role_and_currently_in"
  add_index "channel_members", ["currently_in"], :name => "currently_in"
  add_index "channel_members", ["user_id", "last_seen"], :name => "user_and_last_seen"

  create_table "channel_pictures", :force => true do |t|
    t.column "channel_id",   :integer, :default => 0, :null => false
    t.column "content_type", :string
    t.column "data",         :binary
  end

  add_index "channel_pictures", ["channel_id"], :name => "channel_id", :unique => true

  create_table "channel_transcripts", :force => true do |t|
    t.column "created_at",       :datetime,                    :null => false
    t.column "channel_id",       :integer,  :default => 0,     :null => false
    t.column "system_generated", :boolean,  :default => false, :null => false
    t.column "user_id",          :integer
    t.column "comment",          :string,   :default => "",    :null => false
  end

  add_index "channel_transcripts", ["created_at"], :name => "created_at"
  add_index "channel_transcripts", ["created_at", "channel_id"], :name => "created_at_and_channel"
  add_index "channel_transcripts", ["channel_id"], :name => "channel_id"

  create_table "channels", :force => true do |t|
    t.column "created_at",          :datetime,                                :null => false
    t.column "name",                :string,   :limit => 20,  :default => "", :null => false
    t.column "topic",               :string,   :limit => 100, :default => "", :null => false
    t.column "description",         :string,                  :default => "", :null => false
    t.column "channel_access_id",   :integer,  :limit => 4,   :default => 0,  :null => false
    t.column "channel_category_id", :integer,  :limit => 4,   :default => 0,  :null => false
    t.column "parent_id",           :integer
    t.column "parent_status_id",    :integer,  :limit => 4
    t.column "status_id",           :integer,  :limit => 4,   :default => 0,  :null => false
  end

  add_index "channels", ["name"], :name => "name", :unique => true
  add_index "channels", ["created_at", "status_id"], :name => "created_at_and_status"
  add_index "channels", ["channel_category_id", "status_id"], :name => "channel_category_and_status"
  add_index "channels", ["parent_id", "parent_status_id", "status_id"], :name => "parent_and_parent_status_and_status"

  create_table "event_listener_types", :force => true do |t|
    t.column "name", :string, :limit => 20, :default => "", :null => false
  end

  create_table "event_listeners", :force => true do |t|
    t.column "created_at",             :datetime,                             :null => false
    t.column "event_listener_type_id", :integer,  :limit => 4, :default => 0, :null => false
    t.column "channel_id",             :integer
    t.column "private_message_id",     :integer
    t.column "sending_user_id",        :integer
    t.column "receiving_user_id",      :integer
    t.column "status_id",              :integer,  :limit => 4, :default => 0, :null => false
  end

  add_index "event_listeners", ["receiving_user_id", "status_id"], :name => "receiving_user_and_status"

  create_table "private_message_transcripts", :force => true do |t|
    t.column "created_at",         :datetime,                    :null => false
    t.column "private_message_id", :integer,  :default => 0,     :null => false
    t.column "system_generated",   :boolean,  :default => false, :null => false
    t.column "user_id",            :integer
    t.column "comment",            :string,   :default => "",    :null => false
  end

  add_index "private_message_transcripts", ["created_at"], :name => "created_at"
  add_index "private_message_transcripts", ["created_at", "private_message_id"], :name => "created_at_and_private_message"
  add_index "private_message_transcripts", ["private_message_id"], :name => "private_message_id"

  create_table "private_messages", :force => true do |t|
    t.column "requester_id", :integer,              :default => 0, :null => false
    t.column "requestee_id", :integer,              :default => 0, :null => false
    t.column "status_id",    :integer, :limit => 4, :default => 0, :null => false
  end

  add_index "private_messages", ["requester_id", "status_id"], :name => "requester_and_status"
  add_index "private_messages", ["requestee_id", "status_id"], :name => "requestee_and_status"
  add_index "private_messages", ["requester_id", "requestee_id"], :name => "requester_and_requestee"

  create_table "sessions", :force => true do |t|
    t.column "session_id", :string
    t.column "data",       :text
    t.column "updated_at", :datetime
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "statuses", :force => true do |t|
    t.column "name", :string, :limit => 20, :default => "", :null => false
  end

  create_table "user_flags", :force => true do |t|
    t.column "created_at",        :datetime,                 :null => false
    t.column "sending_user_id",   :integer,  :default => 0,  :null => false
    t.column "receiving_user_id", :integer,  :default => 0,  :null => false
    t.column "reason",            :string,   :default => "", :null => false
  end

  add_index "user_flags", ["created_at", "receiving_user_id"], :name => "created_at_and_receiving_user"
  add_index "user_flags", ["receiving_user_id"], :name => "receiving_user_id"

  create_table "user_pictures", :force => true do |t|
    t.column "user_id",      :integer, :default => 0, :null => false
    t.column "content_type", :string
    t.column "data",         :binary
  end

  add_index "user_pictures", ["user_id"], :name => "user_id", :unique => true

  create_table "user_private_message_accesses", :force => true do |t|
    t.column "name", :string, :limit => 20, :default => "", :null => false
  end

  create_table "user_profile_accesses", :force => true do |t|
    t.column "name", :string, :limit => 20, :default => "", :null => false
  end

  create_table "user_types", :force => true do |t|
    t.column "name", :string, :limit => 20, :default => "", :null => false
  end

  create_table "users", :force => true do |t|
    t.column "created_at",                     :datetime,                                  :null => false
    t.column "name",                           :string,   :limit => 20, :default => "",    :null => false
    t.column "user_type_id",                   :integer,  :limit => 4,  :default => 0,     :null => false
    t.column "email",                          :string,   :limit => 60, :default => "",    :null => false
    t.column "birthday",                       :datetime,                                  :null => false
    t.column "hashed_password",                :string,   :limit => 40, :default => "",    :null => false
    t.column "user_profile_access_id",         :integer,  :limit => 4,  :default => 0,     :null => false
    t.column "user_private_message_access_id", :integer,  :limit => 4,  :default => 0,     :null => false
    t.column "currently_on",                   :boolean,                :default => false, :null => false
    t.column "last_seen",                      :datetime,                                  :null => false
    t.column "first_name",                     :string,   :limit => 20
    t.column "last_name",                      :string,   :limit => 20
    t.column "zipcode",                        :string,   :limit => 10
    t.column "status_id",                      :integer,  :limit => 4,  :default => 2,     :null => false
  end

  add_index "users", ["name"], :name => "name", :unique => true
  add_index "users", ["email"], :name => "email", :unique => true
  add_index "users", ["user_type_id"], :name => "user_type_id"
  add_index "users", ["currently_on"], :name => "currently_on"
  add_index "users", ["user_type_id", "currently_on"], :name => "user_type_and_currently_on"
  add_index "users", ["currently_on", "last_seen"], :name => "currently_on_and_last_seen"

end