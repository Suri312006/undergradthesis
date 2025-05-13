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
  title: "Title of the Thesis",
  author: "Surendra Jammishetti",
  birth-date: "April 1st, 1980",
  birth-place: "Alice Springs, Australia",
  defence-date: "August 28, 2005",
  /* Only one supervisor? The singleton array ("Dr Jack Smith",) needs the
     trailing comma. */
  supervisors: ("Owen B. Arden",),
  committee: (
    "Dr Jack Smith",
    "Prof Dr Jane Williams",
    "Dr Jill Jones",
    "Dr Albert Heijn"),
  degree: "Undergraduate Thesis"
)

#mol-abstract[
  ABSTRACT OF THE THESIS
  
  #lorem(150)
]

#outline()
#include "1-introduction.typ"
#include "2-my-logic.typ"
#include "3-examples.typ"
#pagebreak()

#load-bib(read("refs.bib"), main: true)
