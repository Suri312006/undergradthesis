#import "template.typ": *


#mol-chapter("Key Pairs")

// what are keypair objects ?
Key pairs in Twizzler are the representation of the cryptographic signing schemes
used to create a signed capability, discussed in 3.1.
We design the keypair objects to be agnostic towards what cryptographic
schemes are underneath, allowing for the underlying algorithm to be changed
@twizzler. The keys themselves are stored inside of objects, allowing for
persistent or volatile storage depending on object specification, and
allows for keys themselves to be treated as any other object and have security
policy applied to them. This allows for powerful primitives and rich
expressiveness for describing secruity policy, while also being flexible enough
to make basic policy easy.

Suppose for instance we have Alice on Twizzler, and all users on twizzler
have a "user-root" keypair that allows for them to create an arbitrary number of
objects. Also suppose that access to this user-root keypair is protected by some
login program, where only alice can log in. This now means that Alice now
can create new keypairs, protected by her user-root keypair. Since all her
new keypairs originate from her original user-root keypair, only she can access
the keys required to create new signatures of hers. It forms an elegant solution for
capability creation without the involvement of the kernel.




// how are they represented in twizzler ?

== Abstraction

The `SigningKey` struct is a fixed length byte array with a length field
and an enum specifying what algorithm that key should be interpreted as.
Currently we use the Elliptic Curve Digital Signature Algorithm (ECDSA)
@ecdsa to sign capabilities and verify them, but the simplistic dat
arepresentation allows for any arbitrary alogrithm to be used as long as
the key can be represented as bytes.

Additionally this specification allows
for backward compatibility, allowing for an outdated signing scheme to be used in
support of older programs / files. An existing drawback for backward compatibility is the
maximum size of the buffer we store the key in. Currently we set the maximum size as 256 bytes,
meaning if a future cryptographic signing scheme was to be found with a private key size
larger than 256 bytes, we would have to drop backwards compatibility. Sure this
can be prevented by setting the maximum size to something larger, but that a tradeoff
between possible cryptographic schemes vs the real on-disk cost of larger buffers.

== Compartmentalization
// how they can be used to sign multiple objects (compartmentalization)

To create an object in twizzler, you specify the id of a verifying key
object so the kernel knows which key to use to verify any
capabilities permitting access to the object. You can also specify
default protections for an object or create a capability with the signing
key and any desired permissions.

The neat thing about this design is that you can use a single keypair in-order to use
any arbitrary amount of objects. An example could be a colletion of objects holding files for a class, and grouping all of them
under the same key. In short, having this flexibility allows for a significant debloating
of the filesystem, comparted to creating a new keypair for every single object.

In planned future work , as we talk more about in
we can investiage the  This results in the possibility of finegrained
access control to semantic groupings of objects.
// what the fuck am i trying to say

// all it does is make creation easier, since you only need one pair, it doesnt
// restrict capabilities or whatever. It's just a benefit since we dont have to worry
// about managing a keypair for every single object

#load-bib(read("refs.bib"))
