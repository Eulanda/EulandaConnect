---
weight: 20
---

# Roadmap 2023/2024

Our roadmap represents an exciting journey towards achieving our goals. While we cannot guarantee that all of these points will be realized or the exact timeline, we welcome all ideas and support to help make our vision a reality. If you have any suggestions, or would like to get involved and support our project, please do not hesitate to reach out to us at [info@eulanda.de](mailto:info@eulanda.de). We look forward to collaborating with you!

> Our next major update, **scheduled for June 2023**, will expand the scope of EulandaConnect to over 200 PowerShell functions. This update focuses on streamlining functions, implementing parameter validation, and enabling full XML export, fully compatible with the EULANDA Shop interface. Stay tuned for more exciting updates!

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
4. Enabling the import of **tier prices** from CSV and Excel files
5. Full support for **nopCommerce** 4.2 via ODATA interface `(expected in autumn 2023)`
6. Basic functions for **nopCommerce** 4.6 via REST interface `(expected in summer 2024)`
7. Basic functions for **Shopify** via REST interface  `(expected in spring 2024)`
8. Basic functions for **Shopware** 6.x REST interface `(rescheduled to end-2024)`
9. Output of documents like orders, delivery notes etc. as **HTML**
10. Converting documents from HTML to **PDF** using Pandoc 3.x
11. Adding support for **DeepL** API translation service to enable the translation of product descriptions in supported languages
12. Implementing **Telegram** messaging functions that can send messages and are also compatible with PowerShell 5.x  `(just done)`
13. Expanding the **image** functions to include conversion of BMP files to JPEG or PNG formats.
14. Adding **geo-functions** that can calculate distances based on GPS coordinates  `(just done)`
15. Implementing **modulo** functions that can be used in various scenarios, such as IBAN and Girocode
16. **Examples** of using EulandaConnect