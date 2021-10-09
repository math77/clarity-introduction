;;(impl-trait 'ST1HTBVD3JG9C05J7HBJTHGR0GGW7KXW28M5JS8QE.nft-trait.nft-trait)

(define-non-fungible-token MY_NFT uint)

(define-data-var last-id uint u0)

;; Claim a new nft
(define-public (claim)
    (mint tx-sender))


;; SIP009: Transfer token to a specified principal
(define-public (transfer (token-id uint) (sender principal) (recipient principal))
  (if (and
        (is-eq tx-sender sender))
      
      (match (nft-transfer? MY_NFT token-id sender recipient)
        success (ok success)
        error (err error))
      (err u500)))


;; SIP009: Get the owner of the specified token ID
(define-read-only (get-owner (token-id uint))
  (ok (nft-get-owner? MY_NFT token-id)))

;; SIP009: Get the last token ID
(define-read-only (get-last-token-id)
  (ok (var-get last-id)))

;; SIP009: Get the token URI. You can set it to any other URI
(define-read-only (get-token-uri (token-id uint))
  (ok (some "https://docs.stacks.co")))

;; Internal - Mint new NFT
(define-private (mint (new-owner principal))
    (let ((next-id (+ u1 (var-get last-id))))
      
      (match (nft-mint? MY_NFT next-id new-owner)
        success
          (begin
            (var-set last-id next-id)
            (ok true))
        error (err error))))