#import "template.typ": *

#mol-chapter("Conclusion")

//So, this is more a summary. Which is good to have here, but
// you'll want to have some conclusions -- e.g. What did you learn (e.g. about the
// cost of the operations)
In short we provide a general overview of the critical security
components for security system in Twizzler, along with
implementation details and desgin descisions. The evaluation programs show how
security policy can be expressed and verifies that the kernel is enforcing as
programmed. Lastly we go over microbenchmarks to show and explain the cost of these operations.

The results affirm our intuition that performance would be greatly improved via
caching.  The cost of verifying a signature everytime a new page from an object
had to be mapped into a process's memory space would be redundant. Additionally,
the performance of the kernel verifying signatures is bottlenecked by the
performance of the cryptograhpic scheme, meaning its a good plan to allow for
the addition of new schemes while allowing for backwards compatibility since
adopting a more performant scheme would lead to pure performance gains.

== Future Work

// Maybe go into more detail here. There's a number of things that are discussed
// as future work throughout that could use a couple sentences each here.

There are a number of things I hope to achieve in future work, listed as follows.

- Perform a cost-benefit analysis between key sizes and performance, trying
  to optimimze for a future proof key size in order to maximize backwards
  compatibility.

- Program the kernel to perform access rights checks with a processes secuirty
  context
  during a page fault. I was hoping to get this completed before the end of this
  quarter, but we ran into some bugs and were unable to resolve them in time.
  Once this is hooked up, we plan to design scenarios that test the degress of
  expressivity allowed by our secuirty model to ensure it operates as expected.

- Investigate areas of the secuirty model that could be extended to support
  Decentralized
  Information Flow Control, inspired by the work done in FLUME @flume.

- Create a onboarding process that allows new students to learn the essentials
  of the Twizzler operating system, to foster an environment for increased
  student contributions to the project.

- Clear code documentation so that users wanting to interface with the library
  have an easier time integrating it with their applications.


== Acknowledgements
I couldn't have done the work for this thesis and for Twizzler if it wasn't for the
support I've recieved from my advisor Owen Arden and my technical mentor Daniel Bittman! I
owe both of you so much, not just for this thesis but also for how much I've learned in
this endeavor. Thanks guys!



#load-bib(read("refs.bib"))
