-- Drop tables in reverse order of creation to respect dependencies

-- Disable foreign key checks
SET CONSTRAINTS ALL DEFERRED;


-- Drop tables
DROP TABLE IF EXISTS junction_users_deliveraddresses CASCADE;
DROP TABLE IF EXISTS junction_products_creators CASCADE;
DROP TABLE IF EXISTS junction_products_listmanialists CASCADE;
DROP TABLE IF EXISTS junction_products_categories CASCADE;
DROP TABLE IF EXISTS products_similars CASCADE;
DROP TABLE IF EXISTS tracks CASCADE;
DROP TABLE IF EXISTS junction_cds_labels CASCADE;
DROP TABLE IF EXISTS junction_dvds_audiotexts CASCADE;
DROP TABLE IF EXISTS junction_dvds_studios CASCADE;
DROP TABLE IF EXISTS junction_dvds_actors CASCADE;
DROP TABLE IF EXISTS junction_books_publishers CASCADE;
DROP TABLE IF EXISTS junction_books_authors CASCADE;
DROP TABLE IF EXISTS dvds CASCADE;
DROP TABLE IF EXISTS cds CASCADE;
DROP TABLE IF EXISTS books CASCADE;
DROP TABLE IF EXISTS labels CASCADE;
DROP TABLE IF EXISTS audiotexts CASCADE;
DROP TABLE IF EXISTS dvdformats CASCADE;
DROP TABLE IF EXISTS studios CASCADE;
DROP TABLE IF EXISTS actors CASCADE;
DROP TABLE IF EXISTS publishers CASCADE;
DROP TABLE IF EXISTS authors CASCADE;
DROP TABLE IF EXISTS deliveryaddresses CASCADE;
DROP TABLE IF EXISTS purchases CASCADE;
DROP TABLE IF EXISTS userreviews CASCADE;
DROP TABLE IF EXISTS guestreviews CASCADE;
DROP TABLE IF EXISTS junction_dvds_dvdformats CASCADE;
DROP TABLE IF EXISTS priceinfos CASCADE;
DROP TABLE IF EXISTS shops CASCADE;
DROP TABLE IF EXISTS shopaddresses CASCADE;
DROP TABLE IF EXISTS listmanialists CASCADE;
DROP TABLE IF EXISTS creators CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS bankinfos CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS junction_users_deliveryaddresses CASCADE;

-- Enable foreign key checks (if needed)
-- SET CONSTRAINTS ALL IMMEDIATE;

-- Drop functions
-- DROP FUNCTION validate_url(VARCHAR);