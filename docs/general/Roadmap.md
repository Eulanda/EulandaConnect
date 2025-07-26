---
weight: 20
lastMod: 2023-06-28T17:00:12
---

# Roadmap 2023/2024

Our roadmap represents an exciting journey towards achieving our goals. While we cannot guarantee that all of these points will be realized or the exact timeline, we welcome all ideas and support to help make our vision a reality. If you have any suggestions, or would like to get involved and support our project, please do not hesitate to reach out to us at [info@eulanda.de](mailto:info@eulanda.de). We look forward to collaborating with you!

> Our big June update is here. It expands the scope of EulandaConnect to over 250 PowerShell functions with over 16,000 lines of pure PowerShell source code. This update focuses on streamlining functions, implementing parameter validation, and enabling a full XML export that is fully compatible with the EULANDA Shop interface. Stay tuned for more exciting updates!

1. **Export functions** EulandaXML compatible with shop interface
   1. Stock report (stock*.xml) `(just done)`
   2. Article master data with feature tree, tiered prices, shop extension fields such as variants, stock levels (product*.xml) `(just done)`
   3. Delivery notes (deliveryorder*.xml)  `(just done)`
   4. Address master data (address*.xml)
2. **Import functions** EulandaXML compatible with shop interface
   1. Orders (order*.xml)
   2. Delivery confirmation (deliveryconfirmation*.xml)
   3. Article master data (product*.xml)
   4. Address master data (address*.xml)
3. Implementing a function to **convert** a delivery note into an invoice `(confirmed for june 2023)`
4. Enabling the import of **tier prices** from CSV and Excel files `(just done)`
5. Import Datanorm 4.0 in a PowerShell object structure  `(just done for V+A+B+P)`
6. Full support for **nopCommerce** 4.2 via ODATA interface `(expected in autumn 2023)`
7. Implementing import purchase order (expected in summer 2023)
8. Basic functions for **nopCommerce** 4.6 via REST interface `(expected in summer 2024)`
9. Basic functions for **Shopify** via REST interface  `(expected in spring 2024)`
10. Basic functions for **Shopware** 6.x REST interface `(rescheduled to end-2024)`
11. Output of documents like orders, delivery notes etc. as **HTML**
12. Converting documents from HTML to **PDF** using Pandoc 3.x
13. Adding support for **DeepL** API translation service to enable the translation of product descriptions in supported languages
14. Implementing **Telegram** messaging functions that can send messages and are also compatible with PowerShell 5.x  `(just done)`
15. Expanding the **image** functions to include conversion of BMP files to JPEG or PNG formats.
16. Adding **geo-functions** that can calculate distances based on GPS coordinates  `(just done)`
17. Implementing **modulo** functions that can be used in various scenarios, such as IBAN and Girocode
18. **Examples** of using EulandaConnect
