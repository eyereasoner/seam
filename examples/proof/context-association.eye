dataGraph(association, skolem_g0).
why(
  dataGraph(association, skolem_g0),
  proof(
    goal(dataGraph(association, skolem_g0)),
    by(rule("context-association.eye", clause(9))),
    uses([
      proof(
        goal(context_statement(skolem_g0, bob, foaf_name, "Bob")),
        by(rule("context-association.eye", clause(8))),
        bindings([binding("?contextname", skolem_g0), binding("?subject", bob), binding("?predicate", foaf_name), binding("?object", "Bob"), binding("?context", foaf_name(bob, "Bob"))]),
        uses([
          proof(
            goal(log_nameOf(skolem_g0, foaf_name(bob, "Bob"))),
            by(fact("context-association.eye", clause(5)))
          ),
          proof(
            goal(holds(foaf_name(bob, "Bob"), foaf_name, [bob, "Bob"])),
            by(builtin(holds, 3))
          )
        ])
      )
    ])
  )
).

signatureGraph(association, skolem_g1).
why(
  signatureGraph(association, skolem_g1),
  proof(
    goal(signatureGraph(association, skolem_g1)),
    by(rule("context-association.eye", clause(10))),
    uses([
      proof(
        goal(context_statement(skolem_g1, skolem_g0, sec_proof, dataSignature)),
        by(rule("context-association.eye", clause(8))),
        bindings([binding("?contextname", skolem_g1), binding("?subject", skolem_g0), binding("?predicate", sec_proof), binding("?object", dataSignature), binding("?context", (sec_proof(skolem_g0, dataSignature), type(signature1, sec_DataIntegrityProof), sec_cryptosuite(signature1, "ecdsa-proof-2019"), sec_created(signature1, "2021-11-13T18:19:39Z"), sec_verificationMethod(signature1, "https://university.example/issuers/14#key-1"), sec_proofPurpose(signature1, "assertionMethod"), sec_proofValue(signature1, "z58DAdFfa9SkqZMVPxAQp...jQCrfFPP2oumHKtz"), sec_issuer(signature1, university), sec_validFrom(signature1, "2024-04-03T00:00:00.000Z"), sec_validUntil(signature1, "2025-04-03T00:00:00.000Z")))]),
        uses([
          proof(
            goal(log_nameOf(skolem_g1, (sec_proof(skolem_g0, dataSignature), type(signature1, sec_DataIntegrityProof), sec_cryptosuite(signature1, "ecdsa-proof-2019"), sec_created(signature1, "2021-11-13T18:19:39Z"), sec_verificationMethod(signature1, "https://university.example/issuers/14#key-1"), sec_proofPurpose(signature1, "assertionMethod"), sec_proofValue(signature1, "z58DAdFfa9SkqZMVPxAQp...jQCrfFPP2oumHKtz"), sec_issuer(signature1, university), sec_validFrom(signature1, "2024-04-03T00:00:00.000Z"), sec_validUntil(signature1, "2025-04-03T00:00:00.000Z")))),
            by(fact("context-association.eye", clause(6)))
          ),
          proof(
            goal(holds((sec_proof(skolem_g0, dataSignature), type(signature1, sec_DataIntegrityProof), sec_cryptosuite(signature1, "ecdsa-proof-2019"), sec_created(signature1, "2021-11-13T18:19:39Z"), sec_verificationMethod(signature1, "https://university.example/issuers/14#key-1"), sec_proofPurpose(signature1, "assertionMethod"), sec_proofValue(signature1, "z58DAdFfa9SkqZMVPxAQp...jQCrfFPP2oumHKtz"), sec_issuer(signature1, university), sec_validFrom(signature1, "2024-04-03T00:00:00.000Z"), sec_validUntil(signature1, "2025-04-03T00:00:00.000Z")), sec_proof, [skolem_g0, dataSignature])),
            by(builtin(holds, 3))
          )
        ])
      )
    ])
  )
).

metadataGraph(association, g3).
why(
  metadataGraph(association, g3),
  proof(
    goal(metadataGraph(association, g3)),
    by(rule("context-association.eye", clause(11))),
    uses([
      proof(
        goal(context_statement(g3, skolem_g1, sec_proof, signature2)),
        by(rule("context-association.eye", clause(8))),
        bindings([binding("?contextname", g3), binding("?subject", skolem_g1), binding("?predicate", sec_proof), binding("?object", signature2), binding("?context", (sec_proof(skolem_g1, signature2), type(signature2, sec_DataIntegrityProof), sec_cryptosuite(signature2, "ecdsa-proof-2019"), sec_created(signature2, "2021-11-13T18:19:39Z"), sec_verificationMethod(signature2, "https://university.example/issuers/14#key-1"), sec_proofPurpose(signature2, "assertionMethod"), sec_proofValue(signature2, "adad123efv434r5200...dqed2t44v43das")))]),
        uses([
          proof(
            goal(log_nameOf(g3, (sec_proof(skolem_g1, signature2), type(signature2, sec_DataIntegrityProof), sec_cryptosuite(signature2, "ecdsa-proof-2019"), sec_created(signature2, "2021-11-13T18:19:39Z"), sec_verificationMethod(signature2, "https://university.example/issuers/14#key-1"), sec_proofPurpose(signature2, "assertionMethod"), sec_proofValue(signature2, "adad123efv434r5200...dqed2t44v43das")))),
            by(fact("context-association.eye", clause(7)))
          ),
          proof(
            goal(holds((sec_proof(skolem_g1, signature2), type(signature2, sec_DataIntegrityProof), sec_cryptosuite(signature2, "ecdsa-proof-2019"), sec_created(signature2, "2021-11-13T18:19:39Z"), sec_verificationMethod(signature2, "https://university.example/issuers/14#key-1"), sec_proofPurpose(signature2, "assertionMethod"), sec_proofValue(signature2, "adad123efv434r5200...dqed2t44v43das")), sec_proof, [skolem_g1, signature2])),
            by(builtin(holds, 3))
          )
        ])
      )
    ])
  )
).

