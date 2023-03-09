# Columbus City Government RSS Feeds

**→ [Download the CSV](./feeds.csv) ←**

**→ [Import the OPML](./subscriptions.opml) ←**

**What**: This repository contains a list of all RSS feeds maintained by the City of Columbus using the GovDelivery mailing list service.

**Why**: If you want to see what mailing lists are available. If you want to sign up for every single mailing list, in order to receive the full firehose of content. If you wished that Columbus did a better job of maintaining its website. If you want to have links to publicly-accessible webpages for the emails that Council sends.

**When**: See [the changelog](./changelog.md) for the date of the most-recent scrape, and other changes to this repository.

**How**: The US Coast Guard [published a helpful list of signup URLs and RSS feed URLs](https://www.navcen.uscg.gov/subscribe-email-rss-feeds) for their notices. I compared the two URLs and discovered that, In a signup URL like `https://public.govdelivery.com/accounts/USDHSCG/subscriber/new?topic_id=USDHSCG_65`, the topic ID `USDHSCG_65` is repeated in the RSS feed URL `https://public.govdelivery.com/topics/USDHSCG_65/feed.rss`.

Columbus' website frequently links to GovDelivery signup URLs. For example, [the City Council webpage](https://www.columbus.gov/council/) has a link to `https://public.govdelivery.com/accounts/OHCCC/subscriber/topics?qsp=OHCCC_1`, and searching `columbus.gov` using its search feature revealed several more. From this, I determined that Columbus' newsletters matched the Coast Guard's URL structure, and that Columbus' account ID was `OHCCC`. This string is also visible in the headers of GovDelivery emails as `X-Accountcode: OHCCC`.

[`feeds.csv`](./feeds.csv) is obtained by requesting all possible RSS feeds from 1 to 999 using [`scraper.bash`](./scraper.bash). The feeds are downloaded to the folder `./rss/`. To generate the CSV, [`parser.bash`](./parser.bash) reads all downloaded [RSS files](https://en.wikipedia.org/wiki/RSS) using [xq](https://www.ashbyhq.com/blog/engineering/jq-and-yq) to parse them for their title and other characteristics.

The list is contained in `feeds.csv`, which is a [Comma-Separated Value](https://en.wikipedia.org/wiki/Comma-separated_values) file that you can open in a spreadsheet program such as Excel, Numbers, LibreOffice Calc, or Google Sheets. The data contains the following columns:

- Feed Number: This number, plus Columbus' GovDelivery account ID `OHCCC`, forms the basis of every newsletter list.
- Title: This is extracted from each RSS feed. It is the title of the RSS feed, and probably contains the title of the mailing list.
- Link: This is extracted from each RSS feed. It is the related website URL for the feed, although I note that most URLs are for the maximally-generic domain instead of the more-specific corner of the website.
- Description: This is extracted from each RSS feed. It is the feed's description of itself. I note that it is generally the same as the title.
- Feed URL: This is generated from the ID. It is identical to the URL that was scraped to acquire the feed.
- Newsletter Signup URL: This is generated from the ID. I haven't checked to see if all of these actually have signup pages.
- Most-Recent Date: This is extracted from the RSS feed's first feed item, if it exists. Not all feeds have feed items; not all feed `<item>`s always have dates. (Or my parser is wrong. Feel free to suggest a fix.)
- Number of items: This is how many items are in the feed.

If you find interesting feeds in this list, tell the world, but also tell me on Twitter [@benlkeith](https://twitter.com/benlkeith).

## Oddities

The main OHCCC mailing list seems to be `OHCCC_1`, but the expected feed URL `https://public.govdelivery.com/topics/OHCCC_1/feed.rss` is a 404.

Many feeds have no items. I _suspect_ that this is because:

- there's a retention cutoff, before which GovDelivery no longer keeps bulletins
- there's a cutoff in the query used to generate a feed, before which the RSS feed won't show public webpage URLs for bulletins sent via GovDelivery
- GovDelivery may not have had the public webpage URL feature before sometime in 2020.

## Updating instructions

1. `bash ./scraper.bash`
2. `bash ./parser.bash > feeds.csv`
3. `php subscriptions.opml.php > subscriptions.opml`
4. Update `changelog.md`
5. Commit changes and push
