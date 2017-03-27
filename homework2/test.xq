(: Ivan Lakovic :)

(: 1. the titles of all scenes and acts of the tragedy in the document order; :)
let $q1 := fn:doc("r_and_j.xml")//(ACT|SCENE)/TITLE

(: 2. the list of all persons that speak in the first and the third scene of the third act; :)
let $q2 := distinct-values(fn:doc("r_and_j.xml")//ACT[position()=3]/SCENE[position()=1 or position() = 3]//SPEAKER)

(: 3. the list of all persons that speak in the second and the eighth scene  (counting scenes from the beginning of the drama); :)
let $q3 := distinct-values((fn:doc("r_and_j.xml")//SCENE)[position()=2 or position()=8]//SPEAKER)

(: 4. the titles of all scenes in which Juliet speaks; :)
(: let $q4 := (fn:doc("r_and_j.xml")//SCENE/TITLE[..//SPEAKER = 'JULIET']) :)
let $q4 := fn:doc("r_and_j.xml")//SCENE[.//SPEAKER = 'JULIET']/TITLE

(: 5. the title of the scene in Act I that has the maximal number of the elements LINE; :)
let $q5 := fn:doc("r_and_j.xml")//ACT[1]//SCENE[count(.//LINE) = max(fn:doc("r_and_j.xml")//ACT[1]//SCENE/count(.//LINE))]/TITLE

(: 6. the title of the scene in Act II that has the least number of the elements SPEAKER; :)
let $q6 := fn:doc("r_and_j.xml")//ACT[2]//SCENE[count(.//SPEAKER) = min(fn:doc("r_and_j.xml")//ACT[2]//SCENE/count(.//SPEAKER))]/TITLE

(: 7. how many times the word "love" is said in the scenes in which  Romeo speaks.
	(Be careful!  It is not enough to count the number of LINE elements containing the word "love",
	note also that some words in the play are not said. You can use, e.g., the function "tokenize"); :)
let $q7 := count(fn:doc("r_and_j.xml")//SPEECH[(./SPEAKER = "ROMEO" and count(./LINE) > 0)]/..//LINE[(fn:matches(lower-case(text()), "(^|\s)love[^a-z'-]"))])

(: 8. the list of the persons that never say  "no" (of course they can say, e.g., "now") :)
let $q8 := distinct-values(fn:doc("r_and_j.xml")//SPEAKER[fn:not(. = distinct-values((fn:doc("r_and_j.xml")//LINE[fn:matches(lower-case(text()), "(^|\s)no[^a-z'-]")])/preceding-sibling::SPEAKER))])

(: 9. the list of any 3 speakers that speak in the same scene in which Romeo and Juliet speak but not Benvolio. :)
let $q9 := distinct-values(fn:doc("r_and_j.xml")//SCENE[(.//SPEAKER = "ROMEO" and .//SPEAKER = "JULIET" and fn:not(.//SPEAKER = "BENVOLIO"))]//SPEAKER)[position() < 4]

(: 10. the list of the first 3 speakers in the last act.  :)
let $q10 := distinct-values(fn:doc("r_and_j.xml")//ACT[last()]//SPEAKER)[position() < 4]

(: 11. the first words of Juliet and the last words of Romeo (use the first (resp. last) LINE element). :)
let $q11 := (fn:doc("r_and_j.xml")//SPEAKER[. = "JULIET"]/following-sibling::LINE)[1]|(fn:doc("r_and_j.xml")//SPEAKER[. = "ROMEO"]/following-sibling::LINE)[last()]

(: 12. the last words of Juliet in each scene in which she speaks (the last LINE element for each scene); :)
let $q12 := fn:doc("r_and_j.xml")//SCENE/(SPEECH[./SPEAKER = "JULIET"]/LINE)[last()]

(: 13. the first words of Romeo in each scene in which he speaks; :)
let $q13 := fn:doc("r_and_j.xml")//SCENE/(SPEECH[./SPEAKER = "ROMEO"]/LINE)[1]

(: 14. how many times Juliet speaks directly after Romeo speaks  (according to SPEECH elements); :)
let $q14 := count(fn:doc("r_and_j.xml")//SPEECH[(./SPEAKER = "ROMEO" and following-sibling::SPEECH[1]/SPEAKER = "JULIET")])

(: 15. how many times Romeo speaks in the scenes where Juliet speaks (according to LINE elements); :)
let $q15 := count(fn:doc("r_and_j.xml")//SCENE[.//SPEAKER = "JULIET"]//SPEAKER[. = "ROMEO"]/following-sibling::LINE)

(: 16. the list of persons ordered according to the moment when they speak for the last time; :)
let $q16 := fn:doc("r_and_j.xml")//SPEAKER[fn:not(. = ./following::SPEAKER)]

(: 17. the list of persons that speak at least once directly before Juliet (independently of scene/act boundaries); :)
(: let $q17 := distinct-values(fn:doc("r_and_j.xml")//SPEAKER[./following::SPEAKER[1] = "JULIET"]) :)
let $q17 := distinct-values(fn:doc("r_and_j.xml")//SPEAKER[. = "JULIET"]/preceding::SPEAKER[1])

(: 18. the list of persons that speak at least once directly before Romeo (in the same scene). :)
let $q18 := distinct-values(fn:doc("r_and_j.xml")//(SCENE//SPEAKER)[(. = "ROMEO" and position() > 1)]/preceding::SPEAKER[1])


return <double>
{$q14}
</double>
