#import "template.typ": *


#mol-chapter("Key Pairs")

// what are keypair objects ?
Key pairs in Twizzler are representation of the cryptographic signing
schemes used to create a signed capability, as discussed in 3.1.  We design
the keypair objects to be agnostic towards the underlying scheme to allow for
multiple schemes, as described in @twizzler. This also helps with backwards
compatibilty when adding new, more secure schemes, in the future. The keys
are stored inside of objects, allowing for persistent or volatile
storage depending on object specification, and allows for keys themselves to
be treated as any other object and have security policy applied to them. This
allows for powerful primitives and rich expressiveness for describing secruity
policy, while also being intuitive enough to construct basic policy easily.


== Abstraction

The `SigningKey` struct is a fixed length byte array with a length field
and an enum specifying what algorithm that key should be interpreted as.
Currently we use the Elliptic Curve Digital Signature Algorithm (ECDSA) @ecdsa
to sign capabilities and verify them, but the simplistic data representation
allows for any arbitrary alogrithm to be used as long as the key can be
represented as bytes.

Additionally this specification allows for backward compatibility, allowing
for an outdated signing scheme to be used in support of older programs /
files. An existing drawback for backward compatibility is the maximum size
of the buffer we store the key in. Currently we set the maximum size as 256
bytes, meaning if a future cryptographic signing scheme was to be created with
a key size larger than 256 bytes, we would have to drop backwards
compatibility. Sure this can be prevented now by setting the maximum size to
something larger, but thats a tradeoff between possible cryptographic schemes
vs the real on-disk cost of larger buffers.

== Compartmentalization
// how they can be used to sign multiple objects (compartmentalization)

To create an object in twizzler, you specify the id of a verifying key
object so the kernel knows which key to use to verify any
capabilities permitting access to the object. Since keys are represented as objects
in twizzler, security policy applies on them as well, creating satisfying
solutions in regards to key management.

Suppose for instance we have Alice on Twizzler, and all users on twizzler have
a "user-root" keypair that allows for them to create an arbitrary number of
objects. Also suppose that access to this user-root keypair is protected by
some login program, where only alice can log in. This means that Alice
can create new keypair objects from her user-root keypair. Since all
*her* new keypairs originate from *her* original user-root keypair, only *she* can
access the keys required to create new signatures allowing permissions into
*her* objects. It forms an elegant solution for key management without
the involvement of the kernel.


#load-bib(read("refs.bib"))
