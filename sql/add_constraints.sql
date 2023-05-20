-- Add NOT NULL and UNIQUE constraints

-- #### products
ALTER TABLE products
ADD CONSTRAINT unique_asin UNIQUE (asin),
ADD CONSTRAINT unique_upc UNIQUE (upc),
ADD CONSTRAINT unique_ean UNIQUE (ean);

ALTER TABLE products
ALTER COLUMN asin SET NOT NULL,
ALTER COLUMN ptitle SET NOT NULL,
ALTER COLUMN pgroup SET NOT NULL;

-- #### bankinfos
ALTER TABLE bankinfos
ADD CONSTRAINT unique_bankinfos_id UNIQUE (bankinfo_id);

ALTER TABLE bankinfos
ALTER COLUMN bankinfo_id SET NOT NULL,
ALTER COLUMN account_number SET NOT NULL;

-- #### users
ALTER TABLE users
ADD CONSTRAINT unique_username UNIQUE (username);

ALTER TABLE users
ALTER COLUMN username SET NOT NULL;

-- #### categories
ALTER TABLE categories
ADD CONSTRAINT unique_category_id UNIQUE (category_id);

ALTER TABLE categories
ALTER COLUMN category_id SET NOT NULL,
ALTER COLUMN name SET NOT NULL;

-- #### creators
ALTER TABLE creators
ADD CONSTRAINT unique_creator_id UNIQUE (creator_id);

ALTER TABLE creators
ALTER COLUMN creator_id SET NOT NULL,
ALTER COLUMN name SET NOT NULL;

-- #### listmanialists
ALTER TABLE listmanialists
ADD CONSTRAINT unique_listmanialist_id UNIQUE (listmanialist_id);

ALTER TABLE listmanialists
ALTER COLUMN listmanialist_id SET NOT NULL,
ALTER COLUMN name SET NOT NULL;

-- #### storeaddresses
ALTER TABLE storeaddresses
ADD CONSTRAINT unique_address_id UNIQUE (address_id);

ALTER TABLE storeaddresses
ALTER COLUMN address_id SET NOT NULL,
ALTER COLUMN street SET NOT NULL,
ALTER COLUMN zip SET NOT NULL;

-- #### stores
ALTER TABLE stores
ADD CONSTRAINT unique_store_id UNIQUE (store_id);

ALTER TABLE stores
ALTER COLUMN store_id SET NOT NULL,
ALTER COLUMN storeaddresses_storeaddress_id SET NOT NULL,
ALTER COLUMN name SET NOT NULL;

-- #### priceinfos
ALTER TABLE priceinfos
ADD CONSTRAINT unique_priceinfo_id UNIQUE (priceinfo_id);

ALTER TABLE priceinfos
ALTER COLUMN priceinfo_id SET NOT NULL;

-- #### map_products_priceinfos_stores
ALTER TABLE map_products_priceinfos_stores
ADD CONSTRAINT unique_mapping_products_priceinfos_stores UNIQUE (products_asin, priceinfos_priceinfo_id, stores_store_id);

ALTER TABLE map_products_priceinfos_stores
ALTER COLUMN products_asin SET NOT NULL,
ALTER COLUMN priceinfos_priceinfo_id SET NOT NULL,
ALTER COLUMN stores_store_id SET NOT NULL;

-- #### userreviews
ALTER TABLE userreviews
ADD CONSTRAINT unique_asin_username_in_userreviews UNIQUE (products_asin, users_username);
ADD CONSTRAINT check_rating_range CHECK (rating >= 0 AND rating <= 5);


ALTER TABLE userreviews
ALTER TABLE userreviews
ALTER COLUMN products_asin SET NOT NULL,
ALTER COLUMN users_username SET NOT NULL,
ALTER COLUMN rating INTEGER NOT NULL,
ALTER COLUMN helpful_votes INTEGER NOT NULL,
ALTER COLUMN summary TEXT NOT NULL,
ALTER COLUMN content TEXT NOT NULL,
ALTER COLUMN review_date DATE NOT NULL,
ADD CONSTRAINT check_rating_range CHECK (rating >= 0 AND rating <= 5);

-- #### guestreviews
ALTER TABLE guestreviews
ADD CONSTRAINT unique_guestreview_id UNIQUE (questreview_id);
ADD CONSTRAINT check_rating_range CHECK (rating >= 0 AND rating <= 5);

ALTER TABLE guestreviews
ALTER COLUMN questreview_id SET NOT NULL,
ALTER COLUMN products_asin SET NOT NULL,
ALTER COLUMN rating SET NOT NULL,
ALTER COLUMN helpful_rating SET NOT NULL,
ALTER COLUMN summary SET NOT NULL,
ALTER COLUMN content SET NOT NULL,
ALTER COLUMN review_date SET NOT NULL;

-- #### purchases
ALTER TABLE purchases
ADD CONSTRAINT unique_purchase_id UNIQUE (purchase_id);

ALTER TABLE purchases
ALTER COLUMN purchase_id SET NOT NULL,
ALTER COLUMN products_asin SET NOT NULL,
ALTER COLUMN priceinfos_priceinfo_id SET NOT NULL,
ALTER COLUMN stores_store_id SET NOT NULL,
ALTER COLUMN users_name SET NOT NULL;

-- #### deliveryaddresses
ALTER TABLE deliveryaddresses
ADD CONSTRAINT unique_deliveryaddress_id UNIQUE (deliveryaddress_id);

ALTER TABLE deliveryaddresses
ALTER COLUMN deliveryaddress_id SET NOT NULL,
ALTER COLUMN zip SET NOT NULL,
ALTER COLUMN street SET NOT NULL;

-- #### authors
ALTER TABLE authors
ADD CONSTRAINT unique_author_id UNIQUE (author_id);

ALTER TABLE authors
ALTER COLUMN author_id SET NOT NULL;

-- #### publishers
ALTER TABLE publishers
ADD CONSTRAINT unique_publisher_id UNIQUE (publisher_id);

ALTER TABLE publishers
ALTER COLUMN publisher_id SET NOT NULL;

-- #### actors
ALTER TABLE actors
ADD CONSTRAINT unique_actor_id UNIQUE (actor_id);

ALTER TABLE actors
ALTER COLUMN actor_id SET NOT NULL;

-- #### studios
ALTER TABLE studios
ADD CONSTRAINT unique_studio_id UNIQUE (studio_id);

ALTER TABLE studios
ALTER COLUMN studio_id SET NOT NULL;

-- #### audiotexts
ALTER TABLE audiotexts
ADD CONSTRAINT unique_audiotext_id UNIQUE (audiotext_id);

ALTER TABLE audiotexts
ALTER COLUMN audiotext_id SET NOT NULL;

-- #### labels
ALTER TABLE labels
ADD CONSTRAINT unique_label_id UNIQUE (label_id);

ALTER TABLE labels
ALTER COLUMN label_id SET NOT NULL;

-- #### books
ALTER TABLE books
ADD CONSTRAINT unique_books_asin UNIQUE (asin);

ALTER TABLE books
ALTER COLUMN asin SET NOT NULL;

-- #### cds
ALTER TABLE cds
ADD CONSTRAINT unique_cds_asin UNIQUE (asin);

ALTER TABLE cds
ALTER COLUMN asin SET NOT NULL;

-- #### dvds
ALTER TABLE dvds
ADD CONSTRAINT unique_dvds_asin UNIQUE (asin);

ALTER TABLE dvds
ALTER COLUMN asin SET NOT NULL;

-- #### map_books_authors
ALTER TABLE map_books_authors
ADD CONSTRAINT unique_mapping_books_authors UNIQUE (books_asin, authors_author_id);

ALTER TABLE map_books_authors
ALTER COLUMN books_asin SET NOT NULL,
ALTER COLUMN authors_author_id SET NOT NULL;

-- #### map_books_publishers
ALTER TABLE map_books_publishers
ADD CONSTRAINT unique_mapping_books_publishers UNIQUE (books_asin, publishers_publisher_id);

ALTER TABLE map_books_publishers
ALTER COLUMN books_asin SET NOT NULL,
ALTER COLUMN publishers_publisher_id SET NOT NULL;

-- #### map_dvds_actors
ALTER TABLE map_dvds_actors
ADD CONSTRAINT unique_mapping_dvds_actors UNIQUE (dvds_asin, actors_actor_id);

ALTER TABLE map_dvds_actors
ALTER COLUMN dvds_asin SET NOT NULL,
ALTER COLUMN actors_actor_id SET NOT NULL;

-- #### map_dvds_studios
ALTER TABLE map_dvds_studios
ADD CONSTRAINT unique_mapping_dvds_studios UNIQUE (dvds_asin, studios_studio_id);

ALTER TABLE map_dvds_studios
ALTER COLUMN dvds_asin SET NOT NULL,
ALTER COLUMN studios_studio_id SET NOT NULL;

-- #### map_dvds_audiotexts
ALTER TABLE map_dvds_audiotexts
ADD CONSTRAINT unique_mapping_dvds_audiotexts UNIQUE (dvds_asin, audiotexts_audiotext_id);

ALTER TABLE map_dvds_audiotexts
ALTER COLUMN dvds_asin SET NOT NULL,
ALTER COLUMN audiotexts_audiotext_id SET NOT NULL;

-- #### map_cds_labels
ALTER TABLE map_cds_labels
ADD CONSTRAINT unique_mapping_cds_labels UNIQUE (cds_asin, labels_label_id);

ALTER TABLE map_cds_labels
ALTER COLUMN cds_asin SET NOT NULL,
ALTER COLUMN labels_label_id SET NOT NULL;

-- #### tracks
ALTER TABLE tracks
ADD CONSTRAINT unique_trackname_cd UNIQUE (cds_asin, labels_label_id);

ALTER TABLE tracks
ALTER COLUMN name SET NOT NULL,
ALTER COLUMN cds_asin SET NOT NULL;

-- #### products_similars
ALTER TABLE products_similars
ADD CONSTRAINT unique_mapping_product_similarproduct UNIQUE (products_asin, similars_asin);

ALTER TABLE products_similars
ALTER COLUMN products_asin SET NOT NULL,
ALTER COLUMN similars_asin SET NOT NULL;