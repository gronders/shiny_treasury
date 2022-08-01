# Flipside Crypto R Shiny Template

This is a minimalized R Shiny template app to keep Flipside Shiny apps on-brand. It includes the following:

-   shiny_template R Project
-   app directory with the template app
-   renv lock file (includes shroomDK)
-   relevant gitignores (e.g., ignoring api_key.txt for shroomDK)

## App

The app folder serves as your template R Shiny app. It can be run as is to show filler text and a filler chart. The folder contains:

-   www/
    -   fliplogo.jpg - the Flipside icon
    -   rudderstack.js - requires shinyjs; used to track clicks to the flipside website
    -   styles.css - template css including a few shiny specific outputs (e.g., .container-fluid) review and take care editing
-   global.R - default global file for miscellaneous functions and objects.
-   ui.R - default user interface file, includes both critical tags (e.g., header bar) and optional template code (e.g., chart div)
-   server.R - minimized server file w/ empty server function

## renv

use `renv::restore()` (ensure you have renv downloaded) to restore the app libraries prior to testing on your machine. Note: shroomDK is in active development. This template may fall behind in shroomDK versions. Review the [documentation](https://github.com/FlipsideCrypto/sdk/tree/main/r/shroomDK) for more info.
