@AbapCatalog.sqlViewName: 'S4D430_BOOK'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Solution: Flight Booking w Calculations'
define view S4D430_Booking
  as select from sbook as b
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
      b.customid
}
where
  cancelled <> 'X'
