#import "template.typ": *

#show: mol-thesis


// what am i even supposed to write about maneeee
//
// what have i even done
//
// am i a fraud
//
// 

#mol-titlepage(
  title: "Design, Implementation, and Verification of a Security System for Data-Centric Operating Systems",
  // title: "Gurt",
  author: "Surendra Jammishetti",
  birth-date: "April 1st, 1980",
  birth-place: "Alice Springs, Australia",
  defence-date: "August 28, 2005",
  /* Only one supervisor? The singleton array ("Dr Jack Smith",) needs the
     trailing comma. */
  supervisors: ("Owen B. Arden",),
  //TODO: fix these
  committee: (
    "Dr. Peter Alvaro",
    "Dr. Andi Quinn",
  ),
  degree: "Computer Engineering B.S."
)

#mol-abstract[
  whatevea
  lowkey not even sure what to write
  #lorem(150)
]







// we haveee the introduction, talking about how things are normally done in unix
  // - a critique of why this doesnt work inside of a data-centric operating system, such as twizzler
//
// a solution and design spec of what solves the problems from earlier
//
// benchmarking and analysis
//
// conclusion

#outline()
#include "1-introduction.typ"
#include "2-design.typ"
#include "3-implementation.typ"
#include "4-results.typ"
#include "5-conclusion.typ"
#pagebreak()

#load-bib(read("refs.bib"), main: true)
