# web_search
This repository handles web search across different search engines. For now, only Google and Bing are supported.

___

### Setup
- _Clone the repository and run `bundle install`_
- _Set your API keys environment variables_

#### Set environment variables:
- _For your local environment, you need to add 2 files in the application root folder, called `.env.development` and `.env.test`._
- _For production you must set the environment variables on the bash terminal or in the way you usually do._

**The environment variables are:**
<!-- Google variables -->
_**GOOGLE_CUSTOM_SEARCH_API_KEY:** This is the google custom search API key. You must subscribe to google developers and get one._
_**GOOGLE_PROGRAMMABLE_SEARCH_ENGINE_ID:** This is the google programmable search engine id. You must subscribe to google developers and create one, or just use the default value, which is `017576662512468239146:omuauf_lfve`._

<!-- Bing variables -->
_**BING_SEARCH_API_KEY:** This is the bing web search v7 API key. You must subscriber to azure developers and get one._


To set this values you must add this into your `.env.*` files (for local environment), or execute in your server terminal for production 
```bash
export GOOGLE_CUSTOM_SEARCH_API_KEY=YOUR_GOOGLE_CUSTOM_SEARCHAPI_KEY
export GOOGLE_PROGRAMMABLE_SEARCH_ENGINE_ID=YOUR_SEARCH_ENGINE_ID
export BING_SEARCH_API_KEY=YOUR_BING_WEB_SEARCH_API_KEY
```

___

### Usage
This application exports a `GET` endpoint `/search`, which accepts:
- _**engine:** This is the search engine you want to use. Current this supports `google` (for Google search), `bing` (for Bing search), and `both` (to perform the search on Google and Bing at the same time). **REQUIRED!**_
- _**text:** This will be the term you want to seach in the web. **REQUIRED!**_
- _**per_page:** This is the amount of records per page for each search engine. **OPTIONAL**_
- _**page:** This is the page number of the results for each search engine. **OPTIONAL**_