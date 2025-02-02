use aiken/collection/list
use aiken/crypto.{VerificationKeyHash}
use cardano/transaction.{OutputReference, Transaction}

pub type Datum {
  owner: VerificationKeyHash,
}

pub type Redeemer {
  msg: ByteArray,
}

/// A simple validator which replicates a basic public/private signature lock.
///
/// - The key (hash) is set as datum when the funds are sent to the script address.
/// - The spender is expected to provide a signature, and the string 'Hello, World!' as message
/// - The signature is implicitly verified by the ledger, and included as 'extra_signatories'
///
validator hello_world {
  spend(datum: Option<Datum>, redeemer: Redeemer, _, self: Transaction) {
    expect Some(Datum { owner }) = datum

    let must_say_hello = redeemer.msg == "Hello"

    let must_be_signed = list.has(self.extra_signatories, owner)

    and {
      must_say_hello,
      must_be_signed,
    }
  }

  else(_) {
    fail
  }
}
