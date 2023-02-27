

SELECT *
FROM
(
        SELECT
                 contract_address,
                 project_id,
                 project_id_base_value,
                 collection_name,
                 artist_name,
                 art_collection_unique_id
        FROM `nft_ethereum_metadata`.`art_blocks_collections`
        UNION ALL
        SELECT
                 contract_address,
                 project_id,
                 project_id_base_value,
                 collection_name,
                 artist_name,
                 art_collection_unique_id
        FROM `nft_ethereum_metadata`.`braindrops`
        UNION ALL
        SELECT
                 contract_address,
                 project_id,
                 project_id_base_value,
                 collection_name,
                 artist_name,
                 art_collection_unique_id
        FROM `nft_ethereum_metadata`.`bright_moments`
        UNION ALL
        SELECT
                 contract_address,
                 project_id,
                 project_id_base_value,
                 collection_name,
                 artist_name,
                 art_collection_unique_id
        FROM `nft_ethereum_metadata`.`mirage_gallery_curated`
        UNION ALL
        SELECT
                 contract_address,
                 project_id,
                 project_id_base_value,
                 collection_name,
                 artist_name,
                 art_collection_unique_id
        FROM `nft_ethereum_metadata`.`proof_grails_i`
        UNION ALL
        SELECT
                 contract_address,
                 project_id,
                 project_id_base_value,
                 collection_name,
                 artist_name,
                 art_collection_unique_id
        FROM `nft_ethereum_metadata`.`proof_grails_ii`
        UNION ALL
        SELECT
                 contract_address,
                 project_id,
                 project_id_base_value,
                 collection_name,
                 artist_name,
                 art_collection_unique_id
        FROM `nft_ethereum_metadata`.`verse`
)