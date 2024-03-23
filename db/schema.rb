# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_200_713_190_758) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', precision: nil, null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                    unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.bigint 'byte_size', null: false
    t.string 'checksum', null: false
    t.datetime 'created_at', precision: nil, null: false
    t.string 'service_name'
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'artists', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'slug'
    t.string 'alphabetical_name'
    t.index ['slug'], name: 'index_artists_on_slug', unique: true
  end

  create_table 'artists_records', id: false, force: :cascade do |t|
    t.bigint 'artist_id', null: false
    t.bigint 'record_id', null: false
  end

  create_table 'blogs', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'slug'
    t.text 'description'
    t.index ['slug'], name: 'index_blogs_on_slug', unique: true
  end

  create_table 'labels', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'slug'
    t.index ['slug'], name: 'index_labels_on_slug', unique: true
  end

  create_table 'labels_records', id: false, force: :cascade do |t|
    t.bigint 'label_id', null: false
    t.bigint 'record_id', null: false
    t.index %w[label_id record_id], name: 'index_labels_records_on_label_id_and_record_id'
    t.index %w[record_id label_id], name: 'index_labels_records_on_record_id_and_label_id'
  end

  create_table 'records', force: :cascade do |t|
    t.string 'title'
    t.text 'review'
    t.string 'display_name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'blog_id', null: false
    t.string 'slug'
    t.boolean 'published'
    t.datetime 'published_at', precision: nil
    t.integer 'discogs_id'
    t.index ['blog_id'], name: 'index_records_on_blog_id'
    t.index ['slug'], name: 'index_records_on_slug', unique: true
  end

  create_table 'taggings', id: :integer, default: -> { "nextval('taggings_seq'::regclass)" }, force: :cascade do |t|
    t.integer 'tag_id'
    t.string 'taggable_type'
    t.integer 'taggable_id'
    t.string 'tagger_type'
    t.integer 'tagger_id'
    t.string 'context', limit: 128
    t.datetime 'created_at', precision: nil
    t.index ['context'], name: 'index_taggings_on_context'
    t.index %w[tag_id taggable_id taggable_type context tagger_id tagger_type], name: 'taggings_idx',
                                                                                unique: true
    t.index ['tag_id'], name: 'index_taggings_on_tag_id'
    t.index %w[taggable_id taggable_type context], name: 'taggings_taggable_context_idx'
    t.index %w[taggable_id taggable_type tagger_id context], name: 'taggings_idy'
    t.index ['taggable_id'], name: 'index_taggings_on_taggable_id'
    t.index ['taggable_type'], name: 'index_taggings_on_taggable_type'
    t.index %w[tagger_id tagger_type], name: 'index_taggings_on_tagger_id_and_tagger_type'
    t.index ['tagger_id'], name: 'index_taggings_on_tagger_id'
  end

  create_table 'tags', id: :integer, default: -> { "nextval('tag_seq'::regclass)" }, force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', precision: nil
    t.datetime 'updated_at', precision: nil
    t.integer 'taggings_count', default: 0
    t.index ['name'], name: 'index_tags_on_name', unique: true
  end

  create_table 'users', force: :cascade do |t|
    t.string 'provider', default: 'email', null: false
    t.string 'uid', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at', precision: nil
    t.boolean 'allow_password_change', default: false
    t.datetime 'remember_created_at', precision: nil
    t.string 'confirmation_token'
    t.datetime 'confirmed_at', precision: nil
    t.datetime 'confirmation_sent_at', precision: nil
    t.string 'unconfirmed_email'
    t.string 'name'
    t.string 'nickname'
    t.string 'image'
    t.string 'email'
    t.json 'tokens'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['confirmation_token'], name: 'index_users_on_confirmation_token', unique: true
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
    t.index %w[uid provider], name: 'index_users_on_uid_and_provider', unique: true
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'records', 'blogs'
  add_foreign_key 'taggings', 'tags'
end
