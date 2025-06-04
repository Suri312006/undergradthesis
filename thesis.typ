#import "template.typ": *

#show: mol-thesis



#mol-titlepage(
  // title: "Design, Implementation, and Verification of a Security System for Data-Centric Operating Systems",
  title: "Twizzler-Security\nA Capability-Based Security System for Twizzler",
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

// DANIEL feedback
// overall great start, I'd extend the intro a little bit, its a litte sparse
// and could use a few more things, same thing with future work and conclusion.
//
// run a spell check
//
// more feedback throughout, feel free to take or ignore

#mol-abstract[
  Traditional operating systems permit data access through the kernel, applying
  security policy as a part of that pipeline. The Twizzler operating system
  flips that relationship on its head, focusing on an approach where data
  access is a first-class citizen, getting rid of the kernel as a middleman. 
  This data-centric approach requires us to rethink how security policy
  interacts with users and the kernel. In this thesis, I present the design and
  implementation of core security primitives in Twizzler. Then I evaluate the
  security model with a basic and advanced scenario, as well as microbenchmarks
  of core security operations. Lastly, I discuss future work built off this
  thesis, such as the incorporation of Decentralized Information Flow Control.]







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
#include "2-keypair.typ"
#include "3-cap.typ"
#include "4-secctx.typ"
#include "5-results.typ"
#include "6-conclusion.typ"
#pagebreak()

#load-bib(read("refs.bib"), main: true)
