@AbapCatalog.sqlViewName: 'S4D430_AUTH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Solution: View with Authorization Check'
define view S4d430_Authorization as 
  select 
    from S4D430_Booking as b
      association [1..1] to s4d430_Customer as _Customer
        on b.customid = _Customer.id 
    {   
      key b.carrid,
      key b.connid,
      key b.fldate,
      key b.bookid,
          b.customid,
          b.agencynum,
          b.amount,
          b.currency,  
          b.days_ahead,                                   
         _Customer        
} 
 