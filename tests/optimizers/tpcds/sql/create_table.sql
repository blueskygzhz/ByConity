
CREATE TABLE customer_address (
  ca_address_sk Int64,
  ca_address_id Nullable(String),
  ca_street_number Nullable(String),
  ca_street_name Nullable(String),
  ca_street_type Nullable(String),
  ca_suite_number Nullable(String),
  ca_city Nullable(String),
  ca_county Nullable(String),
  ca_state Nullable(String),
  ca_zip Nullable(String),
  ca_country Nullable(String),
  ca_gmt_offset Nullable(Float64),
  ca_location_type Nullable(String),
  constraint un1 unique(ca_address_sk),
  constraint un2 unique(ca_address_id)
) ENGINE = MergeTree() 
ORDER BY ca_address_sk;

create table customer_demographics (
  cd_demo_sk Int64,
  cd_gender Nullable(String),
  cd_marital_status Nullable(String),
  cd_education_status Nullable(String),
  cd_purchase_estimate Nullable(Int64),
  cd_credit_rating Nullable(String),
  cd_dep_count Nullable(Int64),
  cd_dep_employed_count Nullable(Int64),
  cd_dep_college_count Nullable(Int64),
  constraint un1 unique(cd_demo_sk)
) ENGINE = MergeTree() 
ORDER BY cd_demo_sk;

create table date_dim (
  d_date_sk Int64,
  d_date_id Nullable(String),
  d_date Nullable(date),
  d_month_seq Nullable(Int64),
  d_week_seq Nullable(Int64),
  d_quarter_seq Nullable(Int64),
  d_year Nullable(Int64),
  d_dow Nullable(Int64),
  d_moy Nullable(Int64),
  d_dom Nullable(Int64),
  d_qoy Nullable(Int64),
  d_fy_year Nullable(Int64),
  d_fy_quarter_seq Nullable(Int64),
  d_fy_week_seq Nullable(Int64),
  d_day_name Nullable(String),
  d_quarter_name Nullable(String),
  d_holiday Nullable(String),
  d_weekend Nullable(String),
  d_following_holiday Nullable(String),
  d_first_dom Nullable(Int64),
  d_last_dom Nullable(Int64),
  d_same_day_ly Nullable(Int64),
  d_same_day_lq Nullable(Int64),
  d_current_day Nullable(String),
  d_current_week Nullable(String),
  d_current_month Nullable(String),
  d_current_quarter Nullable(String),
  d_current_year Nullable(String),
  constraint un1 unique(d_date_sk),
  constraint un2 unique(d_date_id)
) ENGINE = MergeTree() 
ORDER BY d_date_sk;

create table income_band (
  ib_income_band_sk Int64,
  ib_lower_bound Nullable(Int64),
  ib_upper_bound Nullable(Int64),
  constraint un1 unique(ib_income_band_sk)
) ENGINE = MergeTree() 
ORDER BY ib_income_band_sk;

create table household_demographics (
  hd_demo_sk Int64,
  hd_income_band_sk Nullable(Int64),
  hd_buy_potential Nullable(String),
  hd_dep_count Nullable(Int64),
  hd_vehicle_count Nullable(Int64),
  constraint fk1 foreign key(hd_income_band_sk) references income_band(ib_income_band_sk),
  constraint un1 unique(hd_demo_sk)
) ENGINE = MergeTree() 
ORDER BY hd_demo_sk;


CREATE TABLE customer (
  c_customer_sk Int64,
  c_customer_id Nullable(String),
  c_current_cdemo_sk Nullable(Int64),
  c_current_hdemo_sk Nullable(Int64),
  c_current_addr_sk Nullable(Int64),
  c_first_shipto_date_sk Nullable(Int64),
  c_first_sales_date_sk Nullable(Int64),
  c_salutation Nullable(String),
  c_first_name Nullable(String),
  c_last_name Nullable(String),
  c_preferred_cust_flag Nullable(String),
  c_birth_day Nullable(Int64),
  c_birth_month Nullable(Int64),
  c_birth_year Nullable(Int64),
  c_birth_country Nullable(String),
  c_login Nullable(String),
  c_email_address Nullable(String),
  c_last_review_date_sk Nullable(Int64),
  constraint fk1 foreign key(c_current_cdemo_sk) references customer_demographics(cd_demo_sk),
  constraint fk2 foreign key(c_current_hdemo_sk) references household_demographics(hd_demo_sk),
  constraint fk3 foreign key(c_current_addr_sk) references customer_address(ca_address_sk),
  constraint fk4 foreign key(c_first_shipto_date_sk) references date_dim(d_date_sk),
  constraint fk5 foreign key(c_first_sales_date_sk) references date_dim(d_date_sk),
  constraint fk6 foreign key(c_last_review_date_sk) references date_dim(d_date_sk),
  constraint un1 unique(c_customer_sk),
  constraint un2 unique(c_customer_id)
) ENGINE = MergeTree() 
ORDER BY c_customer_sk;

create table web_page (
  wp_web_page_sk Int64,
  wp_web_page_id Nullable(String),
  wp_rec_start_date Nullable(date),
  wp_rec_end_date Nullable(date),
  wp_creation_date_sk Nullable(Int64),
  wp_access_date_sk Nullable(Int64),
  wp_autogen_flag Nullable(String),
  wp_customer_sk Nullable(Int64),
  wp_url Nullable(String),
  wp_type Nullable(String),
  wp_char_count Nullable(Int64),
  wp_link_count Nullable(Int64),
  wp_image_count Nullable(Int64),
  wp_max_ad_count Nullable(Int64),
  constraint fk1 foreign key(wp_creation_date_sk) references date_dim(d_date_sk),
  constraint fk2 foreign key(wp_access_date_sk) references date_dim(d_date_sk),
  constraint fk3 foreign key(wp_customer_sk) references customer(c_customer_sk),
  constraint un1 unique(wp_web_page_sk)
) ENGINE = MergeTree() 
ORDER BY wp_web_page_sk;

create table item (
  i_item_sk Int64,
  i_item_id Nullable(String),
  i_rec_start_date Nullable(date),
  i_rec_end_date Nullable(date),
  i_item_desc Nullable(String),
  i_current_price Nullable(Float64),
  i_wholesale_cost Nullable(Float64),
  i_brand_id Nullable(Int64),
  i_brand Nullable(String),
  i_class_id Nullable(Int64),
  i_class Nullable(String),
  i_category_id Nullable(Int64),
  i_category Nullable(String),
  i_manufact_id Nullable(Int64),
  i_manufact Nullable(String),
  i_size Nullable(String),
  i_formulation Nullable(String),
  i_color Nullable(String),
  i_units Nullable(String),
  i_container Nullable(String),
  i_manager_id Nullable(Int64),
  i_product_name Nullable(String),
  constraint un1 unique(i_item_sk)
) ENGINE = MergeTree() 
ORDER BY i_item_sk;

create table promotion (
  p_promo_sk Int64,
  p_promo_id Nullable(String),
  p_start_date_sk Nullable(Int64),
  p_end_date_sk Nullable(Int64),
  p_item_sk Nullable(Int64),
  p_cost Nullable(Float64),
  p_response_target Nullable(Int64),
  p_promo_name Nullable(String),
  p_channel_dmail Nullable(String),
  p_channel_email Nullable(String),
  p_channel_catalog Nullable(String),
  p_channel_tv Nullable(String),
  p_channel_radio Nullable(String),
  p_channel_press Nullable(String),
  p_channel_event Nullable(String),
  p_channel_demo Nullable(String),
  p_channel_details Nullable(String),
  p_purpose Nullable(String),
  p_discount_active Nullable(String),
  constraint fk1 foreign key(p_start_date_sk) references date_dim(d_date_sk),
  constraint fk2 foreign key(p_end_date_sk) references date_dim(d_date_sk),
  constraint fk3 foreign key(p_item_sk) references item(i_item_sk),
  constraint un1 unique(p_promo_sk),
  constraint un2 unique(p_promo_id)
) ENGINE = MergeTree() 
ORDER BY p_promo_sk;

create table reason (
  r_reason_sk Int64,
  r_reason_id Nullable(String),
  r_reason_desc Nullable(String),
  constraint un1 unique(r_reason_sk),
  constraint un2 unique(r_reason_id)
) ENGINE = MergeTree() 
ORDER BY r_reason_sk;

create table ship_mode (
  sm_ship_mode_sk Int64,
  sm_ship_mode_id Nullable(String),
  sm_type Nullable(String),
  sm_code Nullable(String),
  sm_carrier Nullable(String),
  sm_contract Nullable(String),
  constraint un1 unique(sm_ship_mode_sk),
  constraint un2 unique(sm_ship_mode_id)
) ENGINE = MergeTree() 
ORDER BY sm_ship_mode_sk;

create table store (
  s_store_sk Int64,
  s_store_id Nullable(String),
  s_rec_start_date Nullable(date),
  s_rec_end_date Nullable(date),
  s_closed_date_sk Nullable(Int64),
  s_store_name Nullable(String),
  s_number_employees Nullable(Int64),
  s_floor_space Nullable(Int64),
  s_hours Nullable(String),
  s_manager Nullable(String),
  s_market_id Nullable(Int64),
  s_geography_class Nullable(String),
  s_market_desc Nullable(String),
  s_market_manager Nullable(String),
  s_division_id Nullable(Int64),
  s_division_name Nullable(String),
  s_company_id Nullable(Int64),
  s_company_name Nullable(String),
  s_street_number Nullable(String),
  s_street_name Nullable(String),
  s_street_type Nullable(String),
  s_suite_number Nullable(String),
  s_city Nullable(String),
  s_county Nullable(String),
  s_state Nullable(String),
  s_zip Nullable(String),
  s_country Nullable(String),
  s_gmt_offset Nullable(Float64),
  s_tax_percentage Nullable(Float64),
  constraint fk1 foreign key(s_closed_date_sk) references date_dim(d_date_sk),
  constraint un1 unique(s_store_sk)
) ENGINE = MergeTree() 
ORDER BY s_store_sk;

create table time_dim (
  t_time_sk Int64,
  t_time_id Nullable(String),
  t_time Nullable(Int64),
  t_hour Nullable(Int64),
  t_minute Nullable(Int64),
  t_second Nullable(Int64),
  t_am_pm Nullable(String),
  t_shift Nullable(String),
  t_sub_shift Nullable(String),
  t_meal_time Nullable(String),
  constraint un1 unique(t_time_sk),
  constraint un2 unique(t_time_id)
) ENGINE = MergeTree() 
ORDER BY t_time_sk;

create table warehouse (
  w_warehouse_sk Int64,
  w_warehouse_id Nullable(String),
  w_warehouse_name Nullable(String),
  w_warehouse_sq_ft Nullable(Int64),
  w_street_number Nullable(String),
  w_street_name Nullable(String),
  w_street_type Nullable(String),
  w_suite_number Nullable(String),
  w_city Nullable(String),
  w_county Nullable(String),
  w_state Nullable(String),
  w_zip Nullable(String),
  w_country Nullable(String),
  w_gmt_offset Nullable(Float64),
  constraint un1 unique(w_warehouse_sk),
  constraint un2 unique(w_warehouse_id)
) ENGINE = MergeTree() 
ORDER BY w_warehouse_sk;

create table web_site (
  web_site_sk Int64,
  web_site_id Nullable(String),
  web_rec_start_date Nullable(date),
  web_rec_end_date Nullable(date),
  web_name Nullable(String),
  web_open_date_sk Nullable(Int64),
  web_close_date_sk Nullable(Int64),
  web_class Nullable(String),
  web_manager Nullable(String),
  web_mkt_id Nullable(Int64),
  web_mkt_class Nullable(String),
  web_mkt_desc Nullable(String),
  web_market_manager Nullable(String),
  web_company_id Nullable(Int64),
  web_company_name Nullable(String),
  web_street_number Nullable(String),
  web_street_name Nullable(String),
  web_street_type Nullable(String),
  web_suite_number Nullable(String),
  web_city Nullable(String),
  web_county Nullable(String),
  web_state Nullable(String),
  web_zip Nullable(String),
  web_country Nullable(String),
  web_gmt_offset Nullable(Float64),
  web_tax_percentage Nullable(Float64),
  constraint fk1 foreign key(web_open_date_sk) references date_dim(d_date_sk),
  constraint fk2 foreign key(web_close_date_sk) references date_dim(d_date_sk),
  constraint un1 unique(web_site_sk)
) ENGINE = MergeTree() 
ORDER BY web_site_sk;

create table call_center (
  cc_call_center_sk Int64,
  cc_call_center_id Nullable(String),
  cc_rec_start_date Nullable(date),
  cc_rec_end_date Nullable(date),
  cc_closed_date_sk Nullable(Int64),
  cc_open_date_sk Nullable(Int64),
  cc_name Nullable(String),
  cc_class Nullable(String),
  cc_employees Nullable(Int64),
  cc_sq_ft Nullable(Int64),
  cc_hours Nullable(String),
  cc_manager Nullable(String),
  cc_mkt_id Nullable(Int64),
  cc_mkt_class Nullable(String),
  cc_mkt_desc Nullable(String),
  cc_market_manager Nullable(String),
  cc_division Nullable(Int64),
  cc_division_name Nullable(String),
  cc_company Nullable(Int64),
  cc_company_name Nullable(String),
  cc_street_number Nullable(String),
  cc_street_name Nullable(String),
  cc_street_type Nullable(String),
  cc_suite_number Nullable(String),
  cc_city Nullable(String),
  cc_county Nullable(String),
  cc_state Nullable(String),
  cc_zip Nullable(String),
  cc_country Nullable(String),
  cc_gmt_offset Nullable(Float64),
  cc_tax_percentage Nullable(Float64),
  constraint fk1 foreign key(cc_closed_date_sk) references date_dim(d_date_sk),
  constraint fk2 foreign key(cc_open_date_sk) references date_dim(d_date_sk),
  constraint un1 unique(cc_call_center_sk)
) ENGINE = MergeTree() 
ORDER BY cc_call_center_sk;


create table catalog_page (
  cp_catalog_page_sk Int64,
  cp_catalog_page_id Nullable(String),
  cp_start_date_sk Nullable(Int64),
  cp_end_date_sk Nullable(Int64),
  cp_department Nullable(String),
  cp_catalog_number Nullable(Int64),
  cp_catalog_page_number Nullable(Int64),
  cp_description Nullable(String),
  cp_type Nullable(String),
  constraint fk1 foreign key(cp_start_date_sk) references date_dim(d_date_sk),
  constraint fk2 foreign key(cp_end_date_sk) references date_dim(d_date_sk),
  constraint un1 unique(cp_catalog_page_sk),
  constraint un2 unique(cp_catalog_page_id)
) ENGINE = MergeTree() 
ORDER BY cp_catalog_page_sk;


create table catalog_returns (
  cr_returned_date_sk Nullable(Int64),
  cr_returned_time_sk Nullable(Int64),
  cr_item_sk Int64,
  cr_refunded_customer_sk Nullable(Int64),
  cr_refunded_cdemo_sk Nullable(Int64),
  cr_refunded_hdemo_sk Nullable(Int64),
  cr_refunded_addr_sk Nullable(Int64),
  cr_returning_customer_sk Nullable(Int64),
  cr_returning_cdemo_sk Nullable(Int64),
  cr_returning_hdemo_sk Nullable(Int64),
  cr_returning_addr_sk Nullable(Int64),
  cr_call_center_sk Nullable(Int64),
  cr_catalog_page_sk Nullable(Int64),
  cr_ship_mode_sk Nullable(Int64),
  cr_warehouse_sk Nullable(Int64),
  cr_reason_sk Nullable(Int64),
  cr_order_number Nullable(Int64),
  cr_return_quantity Nullable(Int64),
  cr_return_amount Nullable(Float64),
  cr_return_tax Nullable(Float64),
  cr_return_amt_inc_tax Nullable(Float64),
  cr_fee Nullable(Float64),
  cr_return_ship_cost Nullable(Float64),
  cr_refunded_cash Nullable(Float64),
  cr_reversed_charge Nullable(Float64),
  cr_store_credit Nullable(Float64),
  cr_net_loss Nullable(Float64),
  constraint fk1 foreign key(cr_returned_time_sk) references time_dim(t_time_sk),
  constraint fk2 foreign key(cr_returned_date_sk) references date_dim(d_date_sk),
  constraint fk3 foreign key(cr_item_sk) references item(i_item_sk),
  constraint fk4 foreign key(cr_refunded_customer_sk) references customer(c_customer_sk),
  constraint fk5 foreign key(cr_refunded_cdemo_sk) references customer_demographics(cd_demo_sk),
  constraint fk6 foreign key(cr_refunded_hdemo_sk) references household_demographics(hd_demo_sk),
  constraint fk7 foreign key(cr_refunded_addr_sk) references customer_address(ca_address_sk),
  constraint fk8 foreign key(cr_returning_customer_sk) references customer(c_customer_sk),
  constraint fk9 foreign key(cr_returning_cdemo_sk) references customer_demographics(cd_demo_sk),
  constraint fk10 foreign key(cr_returning_hdemo_sk) references household_demographics(hd_demo_sk),
  constraint fk11 foreign key(cr_returning_addr_sk) references customer_address(ca_address_sk),
  constraint fk12 foreign key(cr_call_center_sk) references call_center(cc_call_center_sk),
  constraint fk13 foreign key(cr_catalog_page_sk) references catalog_page(cp_catalog_page_sk),
  constraint fk14 foreign key(cr_ship_mode_sk) references ship_mode(sm_ship_mode_sk),
  constraint fk15 foreign key(cr_warehouse_sk) references warehouse(w_warehouse_sk),
  constraint fk16 foreign key(cr_reason_sk) references reason(r_reason_sk),
  constraint un1 unique(cr_item_sk, cr_order_number)
) ENGINE = MergeTree()
order by cr_item_sk;

create table catalog_sales (
  cs_sold_date_sk Nullable(Int64),
  cs_sold_time_sk Nullable(Int64),
  cs_ship_date_sk Nullable(Int64),
  cs_bill_customer_sk Nullable(Int64),
  cs_bill_cdemo_sk Nullable(Int64),
  cs_bill_hdemo_sk Nullable(Int64),
  cs_bill_addr_sk Nullable(Int64),
  cs_ship_customer_sk Nullable(Int64),
  cs_ship_cdemo_sk Nullable(Int64),
  cs_ship_hdemo_sk Nullable(Int64),
  cs_ship_addr_sk Nullable(Int64),
  cs_call_center_sk Nullable(Int64),
  cs_catalog_page_sk Nullable(Int64),
  cs_ship_mode_sk Nullable(Int64),
  cs_warehouse_sk Nullable(Int64),
  cs_item_sk Int64,
  cs_promo_sk Nullable(Int64),
  cs_order_number Nullable(Int64),
  cs_quantity Nullable(Int64),
  cs_wholesale_cost Nullable(Float64),
  cs_list_price Nullable(Float64),
  cs_sales_price Nullable(Float64),
  cs_ext_discount_amt Nullable(Float64),
  cs_ext_sales_price Nullable(Float64),
  cs_ext_wholesale_cost Nullable(Float64),
  cs_ext_list_price Nullable(Float64),
  cs_ext_tax Nullable(Float64),
  cs_coupon_amt Nullable(Float64),
  cs_ext_ship_cost Nullable(Float64),
  cs_net_paid Nullable(Float64),
  cs_net_paid_inc_tax Nullable(Float64),
  cs_net_paid_inc_ship Nullable(Float64),
  cs_net_paid_inc_ship_tax Nullable(Float64),
  cs_net_profit Nullable(Float64),
  constraint fk1 foreign key(cs_sold_date_sk) references date_dim(d_date_sk),
  constraint fk2 foreign key(cs_sold_time_sk) references time_dim(t_time_sk),
  constraint fk3 foreign key(cs_ship_date_sk) references date_dim(d_date_sk),
  constraint fk4 foreign key(cs_bill_customer_sk) references customer(c_customer_sk),
  constraint fk5 foreign key(cs_bill_cdemo_sk) references customer_demographics(cd_demo_sk),
  constraint fk6 foreign key(cs_bill_hdemo_sk) references household_demographics(hd_demo_sk),
  constraint fk7 foreign key(cs_bill_addr_sk) references customer_address(ca_address_sk),
  constraint fk8 foreign key(cs_ship_customer_sk) references customer(c_customer_sk),
  constraint fk9 foreign key(cs_ship_cdemo_sk) references customer_demographics(cd_demo_sk),
  constraint fk10 foreign key(cs_ship_hdemo_sk) references household_demographics(hd_demo_sk),
  constraint fk11 foreign key(cs_ship_addr_sk) references customer_address(ca_address_sk),
  constraint fk12 foreign key(cs_call_center_sk) references call_center(cc_call_center_sk),
  constraint fk13 foreign key(cs_catalog_page_sk) references catalog_page(cp_catalog_page_sk),
  constraint fk14 foreign key(cs_ship_mode_sk) references ship_mode(sm_ship_mode_sk),
  constraint fk15 foreign key(cs_warehouse_sk) references warehouse(w_warehouse_sk),
  constraint fk16 foreign key(cs_item_sk) references item(i_item_sk),
  constraint fk17 foreign key(cs_promo_sk) references promotion(p_promo_sk),
  constraint un1 unique(cs_item_sk, cs_order_number)
) ENGINE = MergeTree()
order by cs_item_sk;

create table inventory (
  inv_date_sk Nullable(Int64),
  inv_item_sk Int64,
  inv_warehouse_sk Nullable(Int64),
  inv_quantity_on_hand Nullable(Int64),
  constraint fk1 foreign key(inv_date_sk) references date_dim(d_date_sk),
  constraint fk2 foreign key(inv_item_sk) references item(i_item_sk),
  constraint fk3 foreign key(inv_warehouse_sk) references warehouse(w_warehouse_sk),
  constraint un1 unique(inv_date_sk, inv_item_sk, inv_warehouse_sk)
) ENGINE = MergeTree() 
order by inv_item_sk;

create table store_returns (
  sr_returned_date_sk Nullable(Int64),
  sr_return_time_sk Nullable(Int64),
  sr_item_sk Int64,
  sr_customer_sk Nullable(Int64),
  sr_cdemo_sk Nullable(Int64),
  sr_hdemo_sk Nullable(Int64),
  sr_addr_sk Nullable(Int64),
  sr_store_sk Nullable(Int64),
  sr_reason_sk Nullable(Int64),
  sr_ticket_number Nullable(Int64),
  sr_return_quantity Nullable(Int64),
  sr_return_amt Nullable(Float64),
  sr_return_tax Nullable(Float64),
  sr_return_amt_inc_tax Nullable(Float64),
  sr_fee Nullable(Float64),
  sr_return_ship_cost Nullable(Float64),
  sr_refunded_cash Nullable(Float64),
  sr_reversed_charge Nullable(Float64),
  sr_store_credit Nullable(Float64),
  sr_net_loss Nullable(Float64),
  constraint fk1 foreign key(sr_returned_date_sk) references date_dim(d_date_sk),
  constraint fk2 foreign key(sr_return_time_sk) references time_dim(t_time_sk),
  constraint fk3 foreign key(sr_item_sk) references item(i_item_sk),
  constraint fk4 foreign key(sr_customer_sk) references customer(c_customer_sk),
  constraint fk5 foreign key(sr_cdemo_sk) references customer_demographics(cd_demo_sk),
  constraint fk6 foreign key(sr_hdemo_sk) references household_demographics(hd_demo_sk),
  constraint fk7 foreign key(sr_addr_sk) references customer_address(ca_address_sk),
  constraint fk8 foreign key(sr_store_sk) references store(s_store_sk),
  constraint fk9 foreign key(sr_reason_sk) references reason(r_reason_sk),
  constraint un1 unique(sr_item_sk, sr_ticket_number)
) ENGINE = MergeTree() 
order by sr_item_sk;

create table store_sales (
  ss_sold_date_sk Nullable(Int64),
  ss_sold_time_sk Nullable(Int64),
  ss_item_sk Int64,
  ss_customer_sk Nullable(Int64),
  ss_cdemo_sk Nullable(Int64),
  ss_hdemo_sk Nullable(Int64),
  ss_addr_sk Nullable(Int64),
  ss_store_sk Nullable(Int64),
  ss_promo_sk Nullable(Int64),
  ss_ticket_number Nullable(Int64),
  ss_quantity Nullable(Int64),
  ss_wholesale_cost Nullable(Float64),
  ss_list_price Nullable(Float64),
  ss_sales_price Nullable(Float64),
  ss_ext_discount_amt Nullable(Float64),
  ss_ext_sales_price Nullable(Float64),
  ss_ext_wholesale_cost Nullable(Float64),
  ss_ext_list_price Nullable(Float64),
  ss_ext_tax Nullable(Float64),
  ss_coupon_amt Nullable(Float64),
  ss_net_paid Nullable(Float64),
  ss_net_paid_inc_tax Nullable(Float64),
  ss_net_profit Nullable(Float64),
  constraint fk1 foreign key(ss_sold_date_sk) references date_dim(d_date_sk),
  constraint fk2 foreign key(ss_sold_time_sk) references time_dim(t_time_sk),
  constraint fk3 foreign key(ss_item_sk) references item(i_item_sk),
  constraint fk4 foreign key(ss_customer_sk) references customer(c_customer_sk),
  constraint fk5 foreign key(ss_cdemo_sk) references customer_demographics(cd_demo_sk),
  constraint fk6 foreign key(ss_hdemo_sk) references household_demographics(hd_demo_sk),
  constraint fk7 foreign key(ss_addr_sk) references customer_address(ca_address_sk),
  constraint fk8 foreign key(ss_store_sk) references store(s_store_sk),
  constraint fk9 foreign key(ss_promo_sk) references promotion(p_promo_sk),
  constraint un1 unique(ss_item_sk, ss_ticket_number)
) ENGINE = MergeTree() 
order by ss_item_sk;

create table web_returns (
  wr_returned_date_sk Nullable(Int64),
  wr_returned_time_sk Nullable(Int64),
  wr_item_sk Int64,
  wr_refunded_customer_sk Nullable(Int64),
  wr_refunded_cdemo_sk Nullable(Int64),
  wr_refunded_hdemo_sk Nullable(Int64),
  wr_refunded_addr_sk Nullable(Int64),
  wr_returning_customer_sk Nullable(Int64),
  wr_returning_cdemo_sk Nullable(Int64),
  wr_returning_hdemo_sk Nullable(Int64),
  wr_returning_addr_sk Nullable(Int64),
  wr_web_page_sk Nullable(Int64),
  wr_reason_sk Nullable(Int64),
  wr_order_number Nullable(Int64),
  wr_return_quantity Nullable(Int64),
  wr_return_amt Nullable(Float64),
  wr_return_tax Nullable(Float64),
  wr_return_amt_inc_tax Nullable(Float64),
  wr_fee Nullable(Float64),
  wr_return_ship_cost Nullable(Float64),
  wr_refunded_cash Nullable(Float64),
  wr_reversed_charge Nullable(Float64),
  wr_account_credit Nullable(Float64),
  wr_net_loss Nullable(Float64),
  constraint fk1 foreign key(wr_returned_date_sk) references date_dim(d_date_sk),
  constraint fk2 foreign key(wr_returned_time_sk) references time_dim(t_time_sk),
  constraint fk3 foreign key(wr_item_sk) references item(i_item_sk),
  constraint fk4 foreign key(wr_refunded_customer_sk) references customer(c_customer_sk),
  constraint fk5 foreign key(wr_refunded_cdemo_sk) references customer_demographics(cd_demo_sk),
  constraint fk6 foreign key(wr_refunded_hdemo_sk) references household_demographics(hd_demo_sk),
  constraint fk7 foreign key(wr_refunded_addr_sk) references customer_address(ca_address_sk),
  constraint fk8 foreign key(wr_returning_customer_sk) references customer(c_customer_sk),
  constraint fk9 foreign key(wr_returning_cdemo_sk) references customer_demographics(cd_demo_sk),
  constraint fk10 foreign key(wr_returning_hdemo_sk) references household_demographics(hd_demo_sk),
  constraint fk11 foreign key(wr_returning_addr_sk) references customer_address(ca_address_sk),
  constraint fk12 foreign key(wr_web_page_sk) references web_page(wp_web_page_sk),
  constraint fk13 foreign key(wr_reason_sk) references reason(r_reason_sk),
  constraint un1 unique(wr_item_sk, wr_order_number)
) ENGINE = MergeTree() 
order by wr_item_sk;

create table web_sales (
  ws_sold_date_sk Nullable(Int64),
  ws_sold_time_sk Nullable(Int64),
  ws_ship_date_sk Nullable(Int64),
  ws_item_sk Int64,
  ws_bill_customer_sk Nullable(Int64),
  ws_bill_cdemo_sk Nullable(Int64),
  ws_bill_hdemo_sk Nullable(Int64),
  ws_bill_addr_sk Nullable(Int64),
  ws_ship_customer_sk Nullable(Int64),
  ws_ship_cdemo_sk Nullable(Int64),
  ws_ship_hdemo_sk Nullable(Int64),
  ws_ship_addr_sk Nullable(Int64),
  ws_web_page_sk Nullable(Int64),
  ws_web_site_sk Nullable(Int64),
  ws_ship_mode_sk Nullable(Int64),
  ws_warehouse_sk Nullable(Int64),
  ws_promo_sk Nullable(Int64),
  ws_order_number Nullable(Int64),
  ws_quantity Nullable(Int64),
  ws_wholesale_cost Nullable(Float64),
  ws_list_price Nullable(Float64),
  ws_sales_price Nullable(Float64),
  ws_ext_discount_amt Nullable(Float64),
  ws_ext_sales_price Nullable(Float64),
  ws_ext_wholesale_cost Nullable(Float64),
  ws_ext_list_price Nullable(Float64),
  ws_ext_tax Nullable(Float64),
  ws_coupon_amt Nullable(Float64),
  ws_ext_ship_cost Nullable(Float64),
  ws_net_paid Nullable(Float64),
  ws_net_paid_inc_tax Nullable(Float64),
  ws_net_paid_inc_ship Nullable(Float64),
  ws_net_paid_inc_ship_tax Nullable(Float64),
  ws_net_profit Nullable(Float64),
  constraint fk1 foreign key(ws_sold_date_sk) references date_dim(d_date_sk),
  constraint fk2 foreign key(ws_sold_time_sk) references time_dim(t_time_sk),
  constraint fk3 foreign key(ws_ship_date_sk) references date_dim(d_date_sk),
  constraint fk4 foreign key(ws_item_sk) references item(i_item_sk),
  constraint fk5 foreign key(ws_bill_customer_sk) references customer(c_customer_sk),
  constraint fk6 foreign key(ws_bill_cdemo_sk) references customer_demographics(cd_demo_sk),
  constraint fk7 foreign key(ws_bill_hdemo_sk) references household_demographics(hd_demo_sk),
  constraint fk8 foreign key(ws_bill_addr_sk) references customer_address(ca_address_sk),
  constraint fk9 foreign key(ws_ship_customer_sk) references customer(c_customer_sk),
  constraint fk10 foreign key(ws_ship_cdemo_sk) references customer_demographics(cd_demo_sk),
  constraint fk11 foreign key(ws_ship_hdemo_sk) references household_demographics(hd_demo_sk),
  constraint fk12 foreign key(ws_ship_addr_sk) references customer_address(ca_address_sk),
  constraint fk13 foreign key(ws_web_page_sk) references web_page(wp_web_page_sk),
  constraint fk14 foreign key(ws_web_site_sk) references web_site(web_site_sk),
  constraint fk15 foreign key(ws_ship_mode_sk) references ship_mode(sm_ship_mode_sk),
  constraint fk16 foreign key(ws_warehouse_sk) references warehouse(w_warehouse_sk),
  constraint fk17 foreign key(ws_promo_sk) references promotion(p_promo_sk),
  constraint un1 unique(ws_item_sk, ws_order_number)
) ENGINE = MergeTree() 
order by ws_item_sk;
