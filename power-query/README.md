# Power Query (M) code

Exact M code for the 8 loaded queries, copied from the final report.

| File | What it does |
|---|---|
| `Fact_Sales.pq` | Appends D2C + DCart + Nile, adds date parts and `Channel_Key`, matches each sale to the vendor agreement active on its date |
| `Fact_Ads.pq` | Splits the packed `Ad_Descriptor` field, calculates `Ad_Spend = CPC * Clicks` |
| `Fact_Budget.pq` | Reshapes the budget matrix (unpivot months into rows) |
| `Dim_Date.pq` | Generates a 212-day calendar from 1 Jan 2025 |
| `Dim_Product.pq`, `Dim_Category.pq`, `Dim_Channel.pq`, `Dim_Courier.pq` | Dimension tables |

**Not included:** the staging queries (`D2C`, `DCart`, `Nile`, `Dim_CostRates`). They are not loaded into the model (Enable Load off).
- `D2C` and `DCart` use the Folder connector with Combine Files; `Nile` combines the 7 monthly sheets of one workbook.
- `Dim_CostRates` comes from the Cost Structure sheet: Remove Top Rows (1), Use First Row as Headers (twice), then Unpivot Other Columns on Agreement Code / Start_Date / End_Date, renamed to `SKU_Code` and `Unit_Cost`.

File paths in the code (`C:\Users\USER\...`) are local to my machine. Change them to your own folder to run it.
