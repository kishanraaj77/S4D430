@AbapCatalog.sqlViewName: 'S4D430FUNC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Solution: Functions'
define view S4D430_Functions
  as select from sbook   as b
    inner join   scustom as c on b.customid = c.id
{
  key b.carrid,
  key b.connid,
  key b.fldate,
  key b.bookid,
      case b.class
       when 'Y' then 'Economy'
       when 'C' then 'Business'
       when 'F' then 'First'
       else '???'
      end                                                    as class,
      @Semantics.amount.currencyCode:'currency'
      currency_conversion( amount          => b.forcuram,
                           source_currency => b.forcurkey,
                           round           => 'X',
                           target_currency => cast( 'USD' as abap.cuky),
                           exchange_rate_type => 'M',
                           exchange_rate_date => b.order_date,
                        error_handling => 'SET_TO_NULL'    ) as amount,
      @Semantics.currencyCode: true
      cast('USD' as abap.cuky)                               as currency,
      @Semantics.quantity.unitOfMeasure: 'wunit'
      b.luggweight,
      @Semantics.unitOfMeasure: true
      b.wunit,
      b.order_date,
      dats_days_between(b.order_date, b.fldate)              as days_ahead,
      b.agencynum,
      b.counter,
      b.customid,
      concat_with_space(c.form, c.name, 1)                   as name,
      // concat(concat( c.form, ' '), c.name) as name,      // Workaround in 7.40
      c.street,
      c.postcode,
      c.city,
      c.country,
      @EndUserText.label: 'Discount Factor'
      @EndUserText.quickInfo: 'Customer Specific Discount Factor'
      division(cast(c.discount as abap.int4), 100, 2)        as discount
}
where
  cancelled <> 'X'
