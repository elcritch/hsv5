# HSV5: HTML5 Seperated Values

There was a recent [discussion](https://news.ycombinator.com/item?id=28221654) on Hacker News on an article [Time to retire the CSV? (bitsondisk.com)](https://www.bitsondisk.com/writing/2021/retire-the-csv/).
The article makes many excellent points. CSV and it's related family have fundamental problems largely related to lack of formal specification and missing metadata.

However, text formats are often much nicer to use than binary files.
It's easy to open a file in almost any language, do a `line.split('\t')` and be able to import data.
A CSV alternative based on ASCII control codes would resolve many of the problems of either escaping or wrapping the delimiter character. 
Unfortunately it doesn't resolve the lack of metadata which is another major drawback of any character based separator files.
What can we do? 

This repo explores the concept of an `HTML5` based alternative to CSV, TSV, JSONL.
There's a few elements of modern HTML which makes it suitable for a simple text based data-table format. 
It's currently contains a few examples, with the goal of testing how these ideas work out. 

Here's a short _min_ example: 

```html
<link rel="stylesheet" href="prettytable.css" >
<table>
<caption>37547 TEE Electric Powered Rail Car Train Functions (Abbreviated)
<thead>
<tr><th>Function                              <th>Control Unit     <th>Central Station
<tbody>
<tr><td>Headlights                            <td>✔                <td>✔
<tr><td>Interior Lights                       <td>✔                <td>✔
<tr><td>Electric locomotive operating sounds  <td>✔                <td>✔
<tr><td>Engineer's cab lighting               <td>                 <td>✔
<tr><td>Station Announcements - Swiss         <td>                 <td>✔
```

## Detailed Examples 

A fuller example include more _metadata_, which addresses a core downside of CSV:

```html
<!doctype html>
<head>
  <meta charset="utf-8"/>
  <title>Hello</title>
  <link rel="stylesheet" href="prettytable.css" >
</head>

<table >
<caption>37547 TEE Electric Powered Rail Car Train Functions (Abbreviated)
<colgroup>
  <col data-type="string">
  <col data-semantics="checkbox" data-type="boolean" >
  <col data-type="float" data-parser="parseFloat" > 

<thead>
<tr> <th>Function                              <th>Control Unit     <th>Power Ratio

<tbody>
<tr><td>Headlights                            <td>✔                <td>1.92
<tr><td>Interior Lights                       <td>✔                <td>0.34
<tr><td>Electric locomotive operating sounds  <td>✔                <td>2.33
<tr><td>Engineer's cab lighting               <td>                 <td>NaN
<tr><td>Station Announcements - Swiss         <td>                 <td>Infinity
```

If `.hsv5` were to be viable as a modern CSV replacement it would need to define a specification on a core set of `data-*` attributes and basic required elements. Ideally this would include a JavaScript library that would enable any user to open the data-table in any modern browser and have it auto-verify itself. 

Possible future directions:

- Define a common set of `data-*` attributes for column data types
- Specifically defining set types for floats, integers, strings, booleans, etc
- Defining common semantics for data types, or perhaps intent of columns
- Verify minimal standard tags required to satisfy WHATWG / HTML5 specifications

## Background on HTML5 and WHATWG Specification

But wait, isn't HTML5 just another form of XML with endless tags?! We've moved beyond the horrors of XML right?
Luckily HTML5 embraces a more tasteful subset with a more limited subset of default types, but still rich enough to enocde any CSV type data with minimal typing.
It also has a proper fully defined specification [HTML Living Standard](https://html.spec.whatwg.org/multipage/syntax.html).
That standard doesn't include the full complexity of the original `SGML` but still incorporates specific shortcuts that make `HTML5` much more suitable as a human-editable data-table format. 

For example the WHATWG specification states: 
> 13.1.2.4 Optional tags

> Certain tags can be omitted.
> An html element's start tag may be omitted if the first thing inside the html element is not a comment.

For data-table's format these are particularly helpful (from Section 13.1.2.4 - Optional tags - WHATWG):

- A colgroup element's start tag may be omitted if the first thing inside the colgroup element is a col element, and if the element is not immediately preceded by another colgroup element whose end tag has been omitted. (It can't be omitted if the element is empty.)
- A colgroup element's end tag may be omitted if the colgroup element is not immediately followed by ASCII whitespace or a comment.
- A caption element's end tag may be omitted if the caption element is not immediately followed by ASCII whitespace or a comment.
- A thead element's end tag may be omitted if the thead element is immediately followed by a tbody or tfoot element.
- A tbody element's start tag may be omitted if the first thing inside the tbody element is a tr element, and if the element is not immediately preceded by a tbody, thead, or tfoot element whose end tag has been omitted. (It can't be omitted if the element is empty.)
- A tbody element's end tag may be omitted if the tbody element is immediately followed by a tbody or tfoot element, or if there is no more content in the parent element.
- A tr element's end tag may be omitted if the tr element is immediately followed by another tr element, or if there is no more content in the parent element.
- A td element's end tag may be omitted if the td element is immediately followed by a td or th element, or if there is no more content in the parent element.
- A th element's end tag may be omitted if the th element is immediately followed by a td or th element, or if there is no more content in the parent element.