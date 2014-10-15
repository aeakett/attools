#!/usr/bin/zsh

OWNER=`echo $1 | sed 's/.*issuu.com\///' | sed 's/\/.*//'`
DOCNAME=`echo $1 | sed 's/.*\///'`
DOCUMENTID=`wget --output-document=- http://publication.issuu.com/$OWNER/$DOCNAME/ios_1.json | gunzip | jq '.documentId' | tr -d \"`
PAGECOUNT=`wget --output-document=- http://publication.issuu.com/$OWNER/$DOCNAME/ios_1.json |gunzip|jq '.pages|length'`

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

for i in *.jpg
do
   convert $i $i.pdf
   rm $i
done

mmv 'page_*.jpg.pdf' '#1.pdf'

mmv '?.pdf' '0#1.pdf'
mmv '??.pdf' '0#1#2.pdf'

pdfunite *.pdf $DOCNAME.pdf