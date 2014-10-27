#!/usr/bin/zsh

# Non-standard stuff that this script expects to find
# ===================================================
# ZSH (I think this could be replaced with sh if the range in the one for loop was re-written)
# jq (http://stedolan.github.io/jq/)
# convert (from imagemagick which you *probably* have)
# mmv (think about if rename is more common)
# pdfunite (there are probably tons of options for replacement here)

# We should check the value of pdf_pages_available in the json. If it's false then we should just download the jpg pages.

OWNER=`echo $1 | sed 's/.*issuu.com\///' | sed 's/\/.*//'`
DOCNAME=`echo $1 | sed 's/.*\///'`
DOCUMENTID=`wget --output-document=- http://publication.issuu.com/$OWNER/$DOCNAME/ios_1.json | gunzip | jq '.documentId' | tr -d \"`
PAGECOUNT=`wget --output-document=- http://publication.issuu.com/$OWNER/$DOCNAME/ios_1.json | gunzip | jq '.pages|length'`

echo $OWNER
echo $DOCNAME
echo $DOCUMENTID
echo $PAGECOUNT

for i in {1..$PAGECOUNT}
do
   wget http://page-pdf.issuu.com/$DOCUMENTID/$i.pdf
done

for i in `find -type f -empty|sed 's/\.\///'|sed 's/\.pdf//'`
do
   rm $i.pdf
   wget http://image.issuu.com/$DOCUMENTID/jpg/page_$i.jpg
done

for i in `find . -name '*.jpg'`
do
   convert $i $i.pdf
   rm $i
done

echo removing remenants of jpg conversion
mmv 'page_*.jpg.pdf' '#1.pdf'
echo padding single-digit pages
mmv '?.pdf' '0#1.pdf'
echo padding double-digit pages
mmv '??.pdf' '0#1#2.pdf'

# Should maybe try and use documentTitle from the json?
echo concatenating pdfs
pdfunite *.pdf $DOCNAME.pdf
