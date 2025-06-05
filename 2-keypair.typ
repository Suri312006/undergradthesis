#import "template.typ": *


#mol-chapter("Key Pairs")

// what are keypair objects ?
Key-Pairs in Twizzler are two objects, one containing a signing key, and the
other having a verifying key. The signing key is used to form the signature when
creating a capability, while the verifying key is used by the kernel to validate
a capability before granting access rights. More detail can be found about
capability signatures in section 3.1.


They keys are represented as follows:

```rust
struct Key {
    key: [u8; MAX_KEY_SIZE],
    len: u64,
    scheme: SigningScheme,
}
```
Since the underlying data is just a byte array, the keys themselves are
scheme-agnostic, enabling support for multiple cryptograhic schemes, as
described in @twizzler. This also makes backward compatibility trivial when
adding new signing schemes.The keys are stored inside of objects, allowing for
persistent or volatile storage depending on object specification, and allows for
keys themselves to be treated as any other object and have security policy
applied to them.

== Abstraction
Currently we use the Elliptic Curve Digital Signature Algorithm (ECDSA) @ecdsa
to sign capabilities and verify them, but the simplistic data representation
allows for any arbitrary algorithm to be used as long as the key can be
represented as bytes.

An existing drawback for backward compatibility is the maximum size
of the buffer we store the key in. Currently we set the maximum size as 256
bytes, meaning if a future cryptographic signing scheme was to be created with
a key size larger than 256 bytes, we would have to drop backwards
compatibility. While this can be prevented now by setting the maximum size to
something larger, it ends up being tradeoff between possible cryptographic schemes
vs the real on-disk cost of larger buffers, something we plan to investigate in future work.

== Compartmentalization
// how they can be used to sign multiple objects (compartmentalization)

To create an object in twizzler, you specify the ID of a verifying key
object so the kernel knows which key to use to verify any
capabilities permitting access to the object. Since keys are represented as objects
in twizzler, security policy applies on them as well, creating satisfying
solutions in regards to key management.

Suppose for instance we have Alice on Twizzler, and all users on Twizzler have
a "user-root" keypair that allows for them to create an arbitrary number of
objects. Also suppose that access to this user-root keypair is protected by
some login program, where only alice can log in. This means that Alice
can create new keypair objects from her user-root keypair. Since all
*her* new keypairs originate from *her* original user-root keypair, only *she* can
access the keys required to create new signatures allowing permissions into
*her* objects. It forms an elegant solution for key management without
the involvement of the kernel.

// nice, we should talk more about this
#load-bib(read("refs.bib"))
