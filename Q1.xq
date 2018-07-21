(:For each customer, output:
1- customer number and customer name
2- firstname, lastname of the corresponding rep
3- total number of orders placed by that customer:)

<results>
  {
    for $c in doc("../premiere/Customer.xml")//Customer,
        $r in doc("../premiere/Rep.xml")//Rep
    let $o :=  doc("../premiere/Orders.xml")//Orders[CustomerNum = $c/CustomerNum]
    where $c/RepNum = $r/RepNum
    return 
      <row>
        <customer Number = "{ $c/CustomerNum}" Name = "{ $c/CustomerName}"/>
        <rep FirstName = "{ $r/FirstName}"  LastName="{ $r/LastName}"/>
        <orders TotalOrders = "{ count($o) }"/>
      </row>
  }
</results>  