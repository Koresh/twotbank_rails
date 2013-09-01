window.TBank = window.TBank || {}
window.TBank.Deposit = window.TBank.Deposit || {}

class TBank.SendModel extends Backbone.Model

    setLivingAddress:(address) ->
      @LivingAddres = address

    setRegisterAddress:(address) ->
      @RegisterAddres = address

    getLivingAddress:() ->
      @LivingAddres

    getRegisterAddress:() ->
      @RegisterAddres

    save_step:(model)->
      for key, value of model.attributes
        newkey = key.substr(4)
        @set newkey, value

class TBank.Form1 extends Backbone.Form
    cookie_name: 'Form1'
    schema:
        maf_first_name:
            validators: ['name']
        maf_last_name:
            validators: ['name']
        maf_email:
            validators: ['email']
        maf_second_name:
            validators: ['name']
        maf_mobile_phone:
            validators: ['phone']
            mask: "phone"
        maf_birth_date:
            validators: ['date']
            mask: "date"
        maf_accept_rules:
            defaults: false
            validators: ['required']
        maf_sex:
            defaults: 'Мужской'
            validators: ['required']


class TBank.Form1Pif extends Backbone.Form
    cookie_name: 'Form1Pif'
    schema:
        maf_first_name:
            validators: ['name']
        maf_last_name:
            validators: ['name']
        maf_second_name:
            validators: ['name']
        maf_mobile_phone:
            validators: ['phone']
            mask: "phone"
        maf_accept_rules:
            defaults: false
            validators: ['required']



class TBank.Form2 extends Backbone.Form
  cookie_name: 'Form2'
  schema:
    maf_zagran_fio:
      validators: ['latinname']
    maf_changed_fio:
      validators: []
    maf_passport_seria:
      validators: ['pasportseria']
      mask:       "pasportseria"
    maf_passport_number:
      validators: ['pasportnumber']
      mask:       'pasportnumber'
    maf_passport_issue:
      validators: ['date']
      mask:       'date'
    maf_passport_organisation:
      validators: ['simpletext']
    maf_passport_code:
      validators: ['pasportcode']
      mask:       'pasportcode'
    maf_birth_place:
      validators: ['simpletext']
    maf_foreign_relations_flag:
      defaults: 'no'
      validators: ["required"]


class TBank.Form2Pif extends Backbone.Form
  cookie_name: 'Form2Pif'
  schema:
    maf_passport_seria:
      validators: ['pasportseria']
      mask:       "pasportseria"
    maf_passport_number:
      validators: ['pasportnumber']
      mask:       'pasportnumber'
    maf_passport_issue:
      validators: ['date']
      mask:       'date'
    maf_passport_organisation:
      validators: ['simpletext']
    maf_passport_code:
      validators: ['pasportcode']
      mask:       'pasportcode'
    maf_birth_place:
      validators: ['simpletext']


class TBank.Form3 extends Backbone.Form
  cookie_name: 'Form3'
  schema:
    maf_reg_index:
      validators: ["number"]
      mask: "postindex"
    maf_reg_index_forgot:
      validators: []
    maf_reg_region:
      validators: ["address"]
    maf_reg_city:
      validators: ["address"]
    maf_reg_town:
      validators: []
    maf_reg_street:
      validators: ["address"]
    maf_reg_house:
      validators: ["addressnum"]
    maf_reg_flat:
      validators: ["addressnum"]
    maf_register_date:
      validators: ['date']
      mask: "date"
    maf_same_address:
      validators: []
    maf_loc_index:
      validators: ["number"]
      mask: "postindex"
    maf_loc_index_forgot:
      validators: []
    maf_loc_region:
      validators: ["address"]
    maf_loc_city:
      validators: ["address"]
    maf_loc_town:
      validators: []
    maf_loc_street:
      validators: ["address"]
    maf_loc_house:
      validators: ["addressnum"]
    maf_loc_flat:
      validators: ["addressnum"]
    maf_connect_mobile:
      validators: ["phone"]
      mask: "phone"
    maf_connect_phone:
      validators: []
      mask: "phone"
    maf_connect_phone_home:
      validators: []
      defaults: true

class TBank.Form3Pif extends Backbone.Form
  cookie_name: 'Form3Pif'
  schema:
    maf_reg_index:
      validators: ["number"]
      mask: "postindex"
    maf_reg_index_forgot:
      validators: []
    maf_reg_region:
      validators: ["address"]
    maf_reg_city:
      validators: ["address"]
    maf_reg_town:
      validators: []
    maf_reg_street:
      validators: ["address"]
    maf_reg_house:
      validators: ["addressnum"]
    maf_reg_flat:
      validators: ["addressnum"]
    maf_connect_mobile:
      validators: ["phone"]
      mask: "phone"


class TBank.Form4 extends Backbone.Form
  cookie_name: 'Form4'
  schema:
    maf_way_to_get:
      validators: ['required']
      defaults: "office"
    maf_delivery_address:
      validators: ['required']
    maf_city_office:
      validators: []
      defaults: "119334, Москва, Ленинский проспект, 30"
    maf_delivery_city_office:
      validators: []
    maf_delivery_type:
      validators: ['required']
      defaults: "living"
    maf_is_sms:
      validators: ['required']
      defaults: "yes"
    maf_currency_rur:
      validators: []
      defaults: true
    maf_currency_usd:
      validators: []
      defaults: false
    maf_currency_eur:
      validators: []
      defaults: false
    maf_codeword:
      validators: ['codeword']
    maf_call_time:
      validators: []
      defaults: "С 10:00 до 13:00"
    maf_check_code:
      validators: ['checkcode']
    maf_promo_code:
      validators: []


class TBank.Form4Pif extends Backbone.Form
  cookie_name: 'Form4Pif'
  schema:
    maf_way_to_get:
      validators: ['required']
      defaults: "office"
    maf_delivery_address:
      validators: ['required']
    maf_city_office:
      validators: []
      defaults: "119334, Москва, Ленинский проспект, 30"
    maf_delivery_city_office:
      validators: []
    maf_delivery_type:
      validators: ['required']
      defaults: "living"
    maf_visit_time:
      validators: ["datepif"]
      mask: "datepif"
    maf_check_code:
      validators: ['checkcode']


class TBank.Form31 extends Backbone.Form
  cookie_name: 'Form31'
  schema:
    maf_reg_index:
      validators: ["number"]
      mask: "postindex"
    maf_reg_index_forgot:
      validators: []
    maf_reg_region:
      validators: ["address"]
    maf_reg_city:
      validators: ["address"]
    maf_reg_town:
      validators: []
    maf_reg_street:
      validators: ["address"]
    maf_reg_house:
      validators: ["addressnum"]
    maf_reg_flat:
      validators: ["addressnum"]
    maf_register_date:
      validators: ['date']
      mask: "date"
    maf_same_address:
      validators: []
      dependent_keys: ["maf_loc_index", "maf_loc_index_forgot", "maf_loc_index_forgot", "maf_loc_region", "maf_loc_city", "maf_loc_town", "maf_loc_street", "maf_loc_house", "maf_loc_flat"]
    maf_loc_index:
      validators: ["number"]
      mask: "postindex"
    maf_loc_index_forgot:
      validators: []
    maf_loc_region:
      validators: ["address"]
    maf_loc_city:
      validators: ["address"]
    maf_loc_town:
      validators: []
    maf_loc_street:
      validators: ["address"]
    maf_loc_house:
      validators: ["addressnum"]
    maf_loc_flat:
      validators: ["addressnum"]
    maf_connect_mobile:
      validators: ["phone"]
      mask: "phone"
    maf_connect_phone_home:
      validators: []
    maf_connect_phone_name:
      validators: ["simpletext"]
    maf_connect_phone:
      validators: ["phone"]
      mask: "phone"

class TBank.Form41 extends Backbone.Form
  cookie_name: 'Form41'
  schema:
    maf_education:
      validators: ["required"]
    maf_family_status:
      validators: ["required"]
    maf_children_count:
      validators: ["number"]
    maf_work:
      validators: ["required"]
    maf_work_title:
      validators: ["simpletext"]
    maf_work_expirience:
      validators: ["required"]
    maf_work_phone:
      validators: ["phone"]
      mask: "phone"
    maf_work_phone_add:
      validators: []
    maf_credit_sum:
      validators: ["number"]
    maf_monthly_income:
      validators: ["number"]
    maf_monthly_spending:
      validators: ["number"]

    maf_way_to_get:
      validators: ['required']
      defaults: "office"
    maf_delivery_address:
      validators: []
    maf_city_office:
      validators: []
      defaults: "119334, Москва, Ленинский проспект, 30"
    maf_delivery_city_office:
      validators: []
    maf_delivery_type:
      validators: ['required']
      defaults: "living"
    maf_is_sms:
      validators: ['required']
      defaults: "yes"
    maf_currency_rur:
      validators: []
      defaults: true
    maf_currency_usd:
      validators: []
      defaults: false
    maf_currency_eur:
      validators: []
      defaults: false
    maf_codeword:
      validators: ['codeword']
    maf_check_code:
      validators: ['checkcode']
    maf_promo_code:
      validators: []

    maf_work_index:
      validators: ["number"]
      mask: "postindex"
    maf_work_index_forgot:
      validators: []
    maf_work_region:
      validators: ["address"]
    maf_work_city:
      validators: ["address"]
    maf_work_town:
      validators: []
    maf_work_street:
      validators: ["address"]
    maf_work_house:
      validators: ["addressnum"]
    maf_work_flat:
      validators: ["addressnum"]

class TBank.Form41spain extends Backbone.Form
  cookie_name: 'Form41spain'
  schema:
    maf_education:
      validators: ["required"]
    maf_family_status:
      validators: ["required"]
    maf_children_count:
      validators: ["number"]
    maf_work:
      validators: ["required"]
    maf_work_title:
      validators: ["simpletext"]
    maf_work_expirience:
      validators: ["required"]
    maf_work_phone:
      validators: ["phone"]
      mask: "phone"
    maf_work_phone_add:
      validators: []
    maf_credit_sum:
      validators: ["number"]
    maf_monthly_income:
      validators: ["number"]
    maf_monthly_spending:
      validators: ["number"]

    maf_way_to_get:
      validators: ['required']
      defaults: "office"
    maf_delivery_address:
      validators: ['required']
    maf_city_office:
      validators: []
      defaults: "119334, Москва, Ленинский проспект, 30"
    maf_delivery_city_office:
      validators: []
    maf_delivery_type:
      validators: ['required']
      defaults: "living"
    maf_is_sms:
      validators: ['required']
      defaults: "yes"
    maf_currency_rur:
      validators: []
      defaults: true
    maf_currency_usd:
      validators: []
      defaults: false
    maf_currency_eur:
      validators: []
      defaults: false
    maf_codeword:
      validators: ['codeword']
    maf_check_code:
      validators: ['checkcode']
    maf_promo_code:
      validators: []

    maf_work_index:
      validators: ["number"]
      mask: "postindex"
    maf_work_index_forgot:
      validators: []
    maf_work_region:
      validators: ["address"]
    maf_work_city:
      validators: ["address"]
    maf_work_town:
      validators: []
    maf_work_street:
      validators: ["address"]
    maf_work_house:
      validators: ["addressnum"]
    maf_work_flat:
      validators: ["addressnum"]

    maf_visa_from:
      validators: ["date"]
      mask: "date"
    maf_visa_to:
      validators: ["date"]
      mask: "date"
    maf_staying_from:
      validators: ["date"]
      mask: "date"
    maf_staying_to:
      validators: ["date"]
      mask: "date"
    maf_hotel_name:
      validators: ["required"]
    maf_hotel_address:
      validators: ["required"]

class TBank.Form42 extends Backbone.Form
  cookie_name: 'Form42'
  schema:
    maf_education:
      validators: ["required"]
    maf_family_status:
      validators: ["required"]
    maf_children_count:
      validators: ["number"]
    maf_work:
      validators: ["required"]
    maf_work_title:
      validators: ["simpletext"]
    maf_work_expirience:
      validators: ["required"]
    maf_work_phone:
      validators: ["phone"]
      mask: "phone"
    maf_work_phone_add:
      validators: []
    maf_credit_sum:
      validators: ["number"]
    maf_monthly_income:
      validators: ["number"]
    maf_monthly_spending:
      validators: ["number"]

    maf_way_to_get:
      validators: ['required']
      defaults: "office"
    maf_delivery_address:
      validators: ['required']
    maf_city_office:
      validators: []
      defaults: "119334, Москва, Ленинский проспект, 30"
    maf_delivery_city_office:
      validators: []
    maf_delivery_type:
      validators: ['required']
      defaults: "living"
    maf_is_sms:
      validators: ['required']
      defaults: "yes"
    maf_currency_rur:
      validators: []
      defaults: true
    maf_currency_usd:
      validators: []
      defaults: false
    maf_currency_eur:
      validators: []
      defaults: false
    maf_codeword:
      validators: ['codeword']
    maf_check_code:
      validators: ['checkcode']
    maf_promo_code:
      validators: []

    maf_work_index:
      validators: ["number"]
      mask: "postindex"
    maf_work_index_forgot:
      validators: []
    maf_work_region:
      validators: ["address"]
    maf_work_city:
      validators: ["address"]
    maf_work_town:
      validators: []
    maf_work_street:
      validators: ["address"]
    maf_work_house:
      validators: ["addressnum"]
    maf_work_flat:
      validators: ["addressnum"]

    maf_credit_type_1:
      validators: ["required"]
    maf_credit_type_2:
      validators: ["required"]
    maf_credit_type_3:
      validators: ["required"]
    maf_credit_type_4:
      validators: ["required"]

    maf_bank_1:
      validators: ["simpletext"]
    maf_bank_2:
      validators: ["simpletext"]
    maf_bank_3:
      validators: ["simpletext"]
    maf_bank_4:
      validators: ["simpletext"]

    maf_credit_total_1:
      validators: ["number"]
    maf_credit_total_2:
      validators: ["number"]
    maf_credit_total_3:
      validators: ["number"]
    maf_credit_total_4:
      validators: ["number"]

    maf_credit_payment_1:
      validators: ["number"]
    maf_credit_payment_2:
      validators: ["number"]
    maf_credit_payment_3:
      validators: ["number"]
    maf_credit_payment_4:
      validators: ["number"]

    maf_credit_year_1:
      validators: ["number"]
      mask: "year"
    maf_credit_year_2:
      validators: ["number"]
      mask: "year"
    maf_credit_year_3:
      validators: ["number"]
      mask: "year"
    maf_credit_year_4:
      validators: ["number"]
      mask: "year"

    maf_credit_sum_1:
      validators: ["number"]
    maf_credit_sum_2:
      validators: ["number"]
    maf_credit_sum_3:
      validators: ["number"]
    maf_credit_sum_4:
      validators: ["number"]


class TBank.StartBusinessFrom extends Backbone.Form
  cookie_name: 'StartBusinessFrom'
  schema:
    baf_region:
      validators: ["required"]
    baf_city:
      validators: ["country"]
    baf_comp_name:
      validators: ["simpletext"]
    baf_client_name:
      validators: ["simpletext"]
    baf_mobile_phone:
      validators: ["phone"]
      mask: "phone"
    baf_email:
      validators: ["email"]
    baf_is_client:
      validators: ["required"]
      defaults: "no"

class TBank.FinalBusinessForm extends Backbone.Form
  cookie_name: 'FinalBusinessForm'
  schema:
    baf_size_of_state:
      validators: ["number"]
    baf_fot:
      validators: ["number"]
    baf_salary_cards:
      validators: ["number"]
    baf_encashment_cards:
      validators: ["number"]
    baf_date_registration:
      validators: ["date"]
      mask: "date"
    baf_desire_overdraft:
      validators: ["number"]
    baf_product_schet:
      validators: []
      defaults: true
    baf_product_zp:
      validators: []
    baf_product_inckas:
      validators: []
    baf_product_dohod:
      validators: []
    baf_product_overdraft:
      validators: []
    baf_product_acquiring:
      validators: []
    baf_product_business_card:
      validators: []
    baf_product_vklad_na_srok:
      validators: []

class TBank.BuhsoftForm extends Backbone.Form
  cookie_name: 'BuhsoftForm'
  schema:
    baf_buhsoft_company:
      validators: ["simpletext"]
    baf_buhsoft_inn:
      validators: ["required"]
    baf_buhsoft_city:
      validators: ["simpletext"]
    baf_buhsoft_email:
      validators: ['email']
    baf_buhsoft_bank:
      validators: ["simpletext"]
    baf_buhsoft_lastName:
      validators: ['name']
    baf_buhsoft_firstName:
      validators: ['name']
    baf_buhsoft_middleName:
      validators: []
    baf_buhsoft_phoneWork:
      validators: []
      mask: "phone"
    baf_buhsoft_phoneMobi:
      validators: ["phone"]
      mask: "phone"
    baf_personal_data:
      validators: ["required"]
    baf_buhsoft_rko:
      validators: []
    baf_buhsoft_cardCollection:
      validators: []
    baf_buhsoft_tBill:
      validators: []
    baf_buhsoft_payrollService:
      validators: []
    baf_buhsoft_overdraft:
      validators: []
    baf_buhsoft_acquiring:
      validators: []
    baf_buhsoft_businessCard:
      validators: []

class TBank.MTPFormSTEP2 extends Backbone.Form
  cookie_name: 'MTPFormSTEP2'
  schema:
    # Start
    maf_first_name:
        validators: ['name']
    maf_last_name:
        validators: ['name']
    maf_email:
        validators: ['email']
    maf_second_name:
        validators: ['name']
    maf_mobile_phone:
        validators: ['phone']
        mask: "phone"
    maf_birth_date:
        validators: ['date']
        mask: "date"
    maf_sex:
        defaults: 'Мужской'
        validators: ['required']

    # Contact Info
    maf_zagran_fio:
      validators: ['latinname']
    maf_changed_fio:
      validators: []
    maf_passport_seria:
      validators: ['pasportseria']
      mask:       "pasportseria"
    maf_passport_number:
      validators: ['pasportnumber']
      mask:       'pasportnumber'
    maf_passport_issue:
      validators: ['date']
      mask:       'date'
    maf_passport_organisation:
      validators: ['simpletext']
    maf_passport_code:
      validators: ['pasportcode']
      mask:       'pasportcode'
    maf_birth_place:
      validators: ['simpletext']
    maf_foreign_relations_flag:
      defaults: 'no'
      validators: ["required"]

    # Contact Home Phone
    maf_reg_index:
      validators: ["number"]
      mask: "postindex"
    maf_reg_index_forgot:
      validators: []
    maf_reg_region:
      validators: ["address"]
    maf_reg_city:
      validators: ["address"]
    maf_reg_town:
      validators: []
    maf_reg_street:
      validators: ["address"]
    maf_reg_house:
      validators: ["addressnum"]
    maf_reg_flat:
      validators: ["addressnum"]
    maf_register_date:
      validators: ['date']
      mask: "date"
    maf_same_address:
      validators: []
      dependent_keys: ["maf_loc_index", "maf_loc_index_forgot", "maf_loc_index_forgot", "maf_loc_region", "maf_loc_city", "maf_loc_town", "maf_loc_street", "maf_loc_house", "maf_loc_flat"]
    maf_loc_index:
      validators: ["number"]
      mask: "postindex"
    maf_loc_index_forgot:
      validators: []
    maf_loc_region:
      validators: ["address"]
    maf_loc_city:
      validators: ["address"]
    maf_loc_town:
      validators: []
    maf_loc_street:
      validators: ["address"]
    maf_loc_house:
      validators: ["addressnum"]
    maf_loc_flat:
      validators: ["addressnum"]
    maf_connect_mobile:
      validators: ["phone"]
      mask: "phone"
    maf_connect_phone_home:
      validators: []
    maf_connect_phone_name:
      validators: ["simpletext"]
    maf_connect_phone:
      validators: ["phone"]
      mask: "phone"

    # Step4Credit
    maf_education:
      validators: ["required"]
    maf_family_status:
      validators: ["required"]
    maf_children_count:
      validators: ["number"]
    maf_work:
      validators: ["required"]
    maf_work_title:
      validators: ["simpletext"]
    maf_work_expirience:
      validators: ["required"]
    maf_work_phone:
      validators: ["phone"]
      mask: "phone"
    maf_work_phone_add:
      validators: []
    maf_credit_sum:
      validators: ["number"]
    maf_monthly_income:
      validators: ["number"]
    maf_monthly_spending:
      validators: ["number"]

    maf_is_sms:
      validators: ['required']
      defaults: "yes"
    maf_codeword:
      validators: ['codeword']

    maf_work_index:
      validators: ["number"]
      mask: "postindex"
    maf_work_index_forgot:
      validators: []
    maf_work_region:
      validators: ["address"]
    maf_work_city:
      validators: ["address"]
    maf_work_town:
      validators: []
    maf_work_street:
      validators: ["address"]
    maf_work_house:
      validators: ["addressnum"]
    maf_work_flat:
      validators: ["addressnum"]
    maf_lady:
      validators: []
      defaults: 'Покотилова Наталья'

