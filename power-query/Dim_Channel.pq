let
    Source = Fact_Sales,
    #"Removed Columns" = Table.RemoveColumns(Source,{"Source.Name", "Sales_Date", "Delivery_Date", "SKU_Code", "Qty", "Unit_Price", "Line_Amount", "From_Location", "To_Location", "Courier", "City_Tier", "Category", "Order_ID", "Customer_ID", "Payment_Method", "Is_Returned", "Rider_Distance_Km", "Year", "Month", "Week of Year", "Duration_Days"}),
    #"Removed Other Columns" = Table.SelectColumns(#"Removed Columns",{"Channel", "Sub_Channel", "Delivery_Type"}),
    #"Added Custom" = Table.AddColumn(#"Removed Other Columns", "Channel_Key", each [Channel] & "|" & [Sub_Channel] & "|" & [Delivery_Type]),
    #"Removed Duplicates" = Table.Distinct(#"Added Custom")
in
    #"Removed Duplicates"
