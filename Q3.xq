(:For each order number, output:
1- name of the customer who placed that order
2- total number of order line items belong to that order
3- total amount of money (excluding tax) billed for that order:)

<results>
  {
    for $c in doc("../premiere/Customer.xml")//Customer,
        $o in doc("../premiere/Orders.xml")//Orders
    let $l := doc("../premiere/OrderLine.xml")//OrderLine[OrderNum = $o/OrderNum]
    where $c/CustomerNum = $o/CustomerNum and $o/OrderNum = $l/OrderNum
    order by $o/OrderNum ascending
    return 
      <row>
        <order number = "{ $o/OrderNum }"/>
        <customer name= "{ $c/CustomerName}"/>
        <orderline LineItems = "{ count($l)}"/>  
        
        <orderRevenue TotalAmount = " {format-number(sum( 
        for $line in $l 
        let $LineAmount := (data($line/NumOrdered) * data($line/QuotedPrice))
        return 
          $LineAmount
        ),'$,000.00') }"     
           />
      </row>
  }
</results>  