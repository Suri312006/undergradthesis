#import "template.typ": *

#mol-chapter("Conclusion")

//TODO: So, this is more a summary. Which is good to have here, but
// you'll want to have some conclusions -- e.g. What did you learn (e.g. about the
// cost of the operations)
In short we provide a general overview of the critical security
components for security system in Twizzler, along with
implementation details and desgin descisions. The evaluation programs show how
security policy can be expressed and verifies that the kernel is enforcing as
programmed. Lastly we go over microbenchmarks to show and explain the cost of these operations.


== Future Works

// TODO: Maybe go into more detail here. There's a number of things that are discussed
// as future work throughout that could use a couple sentences each here.
In the future I hope to take the primitives created during my thesis, and apply them towards
the implementation of Decentralized Information Flow Control, as described in @flume, into
the Twizzler security model. Additionally I would love to see how the current security model
evolves once we start adding distributed computing support to Twizzler, as described in
the orignal paper @twizzler.


== Acknowledgements
I couldn't have done the work for this thesis and for Twizzler if it wasn't for the
support I've recieved from my advisor Owen Arden and my technical mentor Daniel Bittman! I
owe both of you so much, not just for the class credit but also for how much I've learned in
this endeavor. Thanks guys!



#load-bib(read("refs.bib"))
