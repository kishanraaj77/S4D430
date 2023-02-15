@AbapCatalog.sqlViewAppendName: 'S4D430_EXTVIEW'
@EndUserText.label: 'Solution: View Extension'
extend view S4d430_Extended 
       with S4D430_Extension 
       association[1] to spfli as _connection 
                      on b.carrid = _connection.carrid
                     and b.connid = _connection.connid 
       {
         b.class,
         b.counter,
         _connection 
       } 
 