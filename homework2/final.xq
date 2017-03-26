(: Ivan Lakovic :)

(: 1. fn:doc("r_and_j.xml")//ACT/TITLE|fn:doc("r_and_j.xml")//SCENE/TITLE :)

(: 2. distinct-values(fn:doc("r_and_j.xml")//ACT[position()=3]/SCENE[position()=1 or position() = 3]//SPEAKER) :)

(: 3. distinct-values((fn:doc("r_and_j.xml")//SCENE)[position()=2 or position()=8]//SPEAKER) :)

(: 4. fn:doc("r_and_j.xml")//SCENE[.//SPEAKER = 'JULIET']/TITLE :)

(: 5. fn:doc("r_and_j.xml")//ACT[1]//SCENE[count(.//LINE) = max(fn:doc("r_and_j.xml")//ACT[1]//SCENE/count(.//LINE))]/TITLE :)

(: 6. fn:doc("r_and_j.xml")//ACT[2]//SCENE[count(.//SPEAKER) = min(fn:doc("r_and_j.xml")//ACT[2]//SCENE/count(.//SPEAKER))]/TITLE :)

(: 7. count(fn:doc("r_and_j.xml")//SPEECH[(./SPEAKER = "ROMEO" and count(./LINE) > 0)]/..//LINE[(fn:matches(lower-case(text()), "(^|\s)love[^a-z'-]"))]) :)

(: 8. distinct-values(fn:doc("r_and_j.xml")//SPEAKER[fn:not(. = distinct-values((fn:doc("r_and_j.xml")//LINE[fn:matches(lower-case(text()), "(^|\s)no[^a-z'-]")])/preceding-sibling::SPEAKER))]) :)

(: 9. distinct-values(fn:doc("r_and_j.xml")//SCENE[(.//SPEAKER = "ROMEO" and .//SPEAKER = "JULIET" and fn:not(.//SPEAKER = "BENVOLIO"))]//SPEAKER)[position() < 4] :)

(: 10. distinct-values(fn:doc("r_and_j.xml")//ACT[last()]//SPEAKER)[position() < 4] :)

(: 11. (fn:doc("r_and_j.xml")//SPEAKER[. = "JULIET"]/following-sibling::LINE)[1]|(fn:doc("r_and_j.xml")//SPEAKER[. = "ROMEO"]/following-sibling::LINE)[last()] :)

(: 12. fn:doc("r_and_j.xml")//SCENE/(SPEECH[./SPEAKER = "JULIET"]/LINE)[last()] :)

(: 13. fn:doc("r_and_j.xml")//SCENE/(SPEECH[./SPEAKER = "ROMEO"]/LINE)[1] :)

(: 14. count(fn:doc("r_and_j.xml")//SPEECH[(./SPEAKER = "ROMEO" and following-sibling::SPEECH/SPEAKER = "JULIET")]) :)

(: 15. count(fn:doc("r_and_j.xml")//SCENE[.//SPEAKER = "JULIET"]//SPEAKER[. = "ROMEO"]/following-sibling::LINE) :)

(: 16. fn:doc("r_and_j.xml")//SPEAKER[fn:not(. = ./following::SPEAKER)] :)

(: 17. distinct-values(fn:doc("r_and_j.xml")//SPEAKER[. = "JULIET"]/preceding::SPEAKER[1]) :)

(: 18. distinct-values(fn:doc("r_and_j.xml")//(SCENE//SPEAKER)[(. = "ROMEO" and position() > 1)]/preceding::SPEAKER[1]) :)
