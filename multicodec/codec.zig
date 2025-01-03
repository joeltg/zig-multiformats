const std = @import("std");
const varint = @import("varint");

pub const Codec = enum(u32) {
    // zig fmt: off
    @"identity" = 0x00,
    @"cidv1" = 0x01,
    @"cidv2" = 0x02,
    @"cidv3" = 0x03,
    @"ip4" = 0x04,
    @"tcp" = 0x06,
    @"sha1" = 0x11,
    @"sha2-256" = 0x12,
    @"sha2-512" = 0x13,
    @"sha3-512" = 0x14,
    @"sha3-384" = 0x15,
    @"sha3-256" = 0x16,
    @"sha3-224" = 0x17,
    @"shake-128" = 0x18,
    @"shake-256" = 0x19,
    @"keccak-224" = 0x1a,
    @"keccak-256" = 0x1b,
    @"keccak-384" = 0x1c,
    @"keccak-512" = 0x1d,
    @"blake3" = 0x1e,
    @"sha2-384" = 0x20,
    @"dccp" = 0x21,
    @"murmur3-x64-64" = 0x22,
    @"murmur3-32" = 0x23,
    @"ip6" = 0x29,
    @"ip6zone" = 0x2a,
    @"ipcidr" = 0x2b,
    @"path" = 0x2f,
    @"multicodec" = 0x30,
    @"multihash" = 0x31,
    @"multiaddr" = 0x32,
    @"multibase" = 0x33,
    @"varsig" = 0x34,
    @"dns" = 0x35,
    @"dns4" = 0x36,
    @"dns6" = 0x37,
    @"dnsaddr" = 0x38,
    @"protobuf" = 0x50,
    @"cbor" = 0x51,
    @"raw" = 0x55,
    @"dbl-sha2-256" = 0x56,
    @"rlp" = 0x60,
    @"bencode" = 0x63,
    @"dag-pb" = 0x70,
    @"dag-cbor" = 0x71,
    @"libp2p-key" = 0x72,
    @"git-raw" = 0x78,
    @"torrent-info" = 0x7b,
    @"torrent-file" = 0x7c,
    @"blake3-hashseq" = 0x80,
    @"leofcoin-block" = 0x81,
    @"leofcoin-tx" = 0x82,
    @"leofcoin-pr" = 0x83,
    @"sctp" = 0x84,
    @"dag-jose" = 0x85,
    @"dag-cose" = 0x86,
    @"lbry" = 0x8c,
    @"eth-block" = 0x90,
    @"eth-block-list" = 0x91,
    @"eth-tx-trie" = 0x92,
    @"eth-tx" = 0x93,
    @"eth-tx-receipt-trie" = 0x94,
    @"eth-tx-receipt" = 0x95,
    @"eth-state-trie" = 0x96,
    @"eth-account-snapshot" = 0x97,
    @"eth-storage-trie" = 0x98,
    @"eth-receipt-log-trie" = 0x99,
    @"eth-receipt-log" = 0x9a,
    @"aes-128" = 0xa0,
    @"aes-192" = 0xa1,
    @"aes-256" = 0xa2,
    @"chacha-128" = 0xa3,
    @"chacha-256" = 0xa4,
    @"bitcoin-block" = 0xb0,
    @"bitcoin-tx" = 0xb1,
    @"bitcoin-witness-commitment" = 0xb2,
    @"zcash-block" = 0xc0,
    @"zcash-tx" = 0xc1,
    @"caip-50" = 0xca,
    @"streamid" = 0xce,
    @"stellar-block" = 0xd0,
    @"stellar-tx" = 0xd1,
    @"md4" = 0xd4,
    @"md5" = 0xd5,
    @"decred-block" = 0xe0,
    @"decred-tx" = 0xe1,
    @"ipld" = 0xe2,
    @"ipfs" = 0xe3,
    @"swarm" = 0xe4,
    @"ipns" = 0xe5,
    @"zeronet" = 0xe6,
    @"secp256k1-pub" = 0xe7,
    @"dnslink" = 0xe8,
    @"bls12_381-g1-pub" = 0xea,
    @"bls12_381-g2-pub" = 0xeb,
    @"x25519-pub" = 0xec,
    @"ed25519-pub" = 0xed,
    @"bls12_381-g1g2-pub" = 0xee,
    @"sr25519-pub" = 0xef,
    @"dash-block" = 0xf0,
    @"dash-tx" = 0xf1,
    @"swarm-manifest" = 0xfa,
    @"swarm-feed" = 0xfb,
    @"beeson" = 0xfc,
    @"udp" = 0x0111,
    @"p2p-webrtc-star" = 0x0113,
    @"p2p-webrtc-direct" = 0x0114,
    @"p2p-stardust" = 0x0115,
    @"webrtc-direct" = 0x0118,
    @"webrtc" = 0x0119,
    @"p2p-circuit" = 0x0122,
    @"dag-json" = 0x0129,
    @"udt" = 0x012d,
    @"utp" = 0x012e,
    @"crc32" = 0x0132,
    @"crc64-ecma" = 0x0164,
    @"unix" = 0x0190,
    @"thread" = 0x0196,
    @"p2p" = 0x01a5,
    @"https" = 0x01bb,
    @"onion" = 0x01bc,
    @"onion3" = 0x01bd,
    @"garlic64" = 0x01be,
    @"garlic32" = 0x01bf,
    @"tls" = 0x01c0,
    @"sni" = 0x01c1,
    @"noise" = 0x01c6,
    @"shs" = 0x01c8,
    @"quic" = 0x01cc,
    @"quic-v1" = 0x01cd,
    @"webtransport" = 0x01d1,
    @"certhash" = 0x01d2,
    @"ws" = 0x01dd,
    @"wss" = 0x01de,
    @"p2p-websocket-star" = 0x01df,
    @"http" = 0x01e0,
    @"http-path" = 0x01e1,
    @"swhid-1-snp" = 0x01f0,
    @"json" = 0x0200,
    @"messagepack" = 0x0201,
    @"car" = 0x0202,
    @"ipns-record" = 0x0300,
    @"libp2p-peer-record" = 0x0301,
    @"libp2p-relay-rsvp" = 0x0302,
    @"memorytransport" = 0x0309,
    @"car-index-sorted" = 0x0400,
    @"car-multihash-index-sorted" = 0x0401,
    @"transport-bitswap" = 0x0900,
    @"transport-graphsync-filecoinv1" = 0x0910,
    @"transport-ipfs-gateway-http" = 0x0920,
    @"multidid" = 0x0d1d,
    @"sha2-256-trunc254-padded" = 0x1012,
    @"sha2-224" = 0x1013,
    @"sha2-512-224" = 0x1014,
    @"sha2-512-256" = 0x1015,
    @"murmur3-x64-128" = 0x1022,
    @"ripemd-128" = 0x1052,
    @"ripemd-160" = 0x1053,
    @"ripemd-256" = 0x1054,
    @"ripemd-320" = 0x1055,
    @"x11" = 0x1100,
    @"p256-pub" = 0x1200,
    @"p384-pub" = 0x1201,
    @"p521-pub" = 0x1202,
    @"ed448-pub" = 0x1203,
    @"x448-pub" = 0x1204,
    @"rsa-pub" = 0x1205,
    @"sm2-pub" = 0x1206,
    @"vlad" = 0x1207,
    @"provenance-log" = 0x1208,
    @"provenance-log-entry" = 0x1209,
    @"provenance-log-script" = 0x120a,
    @"mlkem-512-pub" = 0x120b,
    @"mlkem-768-pub" = 0x120c,
    @"mlkem-1024-pub" = 0x120d,
    @"multisig" = 0x1239,
    @"multikey" = 0x123a,
    @"nonce" = 0x123b,
    @"ed25519-priv" = 0x1300,
    @"secp256k1-priv" = 0x1301,
    @"x25519-priv" = 0x1302,
    @"sr25519-priv" = 0x1303,
    @"rsa-priv" = 0x1305,
    @"p256-priv" = 0x1306,
    @"p384-priv" = 0x1307,
    @"p521-priv" = 0x1308,
    @"bls12_381-g1-priv" = 0x1309,
    @"bls12_381-g2-priv" = 0x130a,
    @"bls12_381-g1g2-priv" = 0x130b,
    @"bls12_381-g1-pub-share" = 0x130c,
    @"bls12_381-g2-pub-share" = 0x130d,
    @"bls12_381-g1-priv-share" = 0x130e,
    @"bls12_381-g2-priv-share" = 0x130f,
    @"lamport-sha3-512-pub" = 0x1a14,
    @"lamport-sha3-384-pub" = 0x1a15,
    @"lamport-sha3-256-pub" = 0x1a16,
    @"lamport-sha3-512-priv" = 0x1a24,
    @"lamport-sha3-384-priv" = 0x1a25,
    @"lamport-sha3-256-priv" = 0x1a26,
    @"lamport-sha3-512-priv-share" = 0x1a34,
    @"lamport-sha3-384-priv-share" = 0x1a35,
    @"lamport-sha3-256-priv-share" = 0x1a36,
    @"lamport-sha3-512-sig" = 0x1a44,
    @"lamport-sha3-384-sig" = 0x1a45,
    @"lamport-sha3-256-sig" = 0x1a46,
    @"lamport-sha3-512-sig-share" = 0x1a54,
    @"lamport-sha3-384-sig-share" = 0x1a55,
    @"lamport-sha3-256-sig-share" = 0x1a56,
    @"kangarootwelve" = 0x1d01,
    @"aes-gcm-256" = 0x2000,
    @"silverpine" = 0x3f42,
    @"sm3-256" = 0x534d,
    @"sha256a" = 0x7012,
    @"chacha20-poly1305" = 0xa000,
    @"blake2b-8" = 0xb201,
    @"blake2b-16" = 0xb202,
    @"blake2b-24" = 0xb203,
    @"blake2b-32" = 0xb204,
    @"blake2b-40" = 0xb205,
    @"blake2b-48" = 0xb206,
    @"blake2b-56" = 0xb207,
    @"blake2b-64" = 0xb208,
    @"blake2b-72" = 0xb209,
    @"blake2b-80" = 0xb20a,
    @"blake2b-88" = 0xb20b,
    @"blake2b-96" = 0xb20c,
    @"blake2b-104" = 0xb20d,
    @"blake2b-112" = 0xb20e,
    @"blake2b-120" = 0xb20f,
    @"blake2b-128" = 0xb210,
    @"blake2b-136" = 0xb211,
    @"blake2b-144" = 0xb212,
    @"blake2b-152" = 0xb213,
    @"blake2b-160" = 0xb214,
    @"blake2b-168" = 0xb215,
    @"blake2b-176" = 0xb216,
    @"blake2b-184" = 0xb217,
    @"blake2b-192" = 0xb218,
    @"blake2b-200" = 0xb219,
    @"blake2b-208" = 0xb21a,
    @"blake2b-216" = 0xb21b,
    @"blake2b-224" = 0xb21c,
    @"blake2b-232" = 0xb21d,
    @"blake2b-240" = 0xb21e,
    @"blake2b-248" = 0xb21f,
    @"blake2b-256" = 0xb220,
    @"blake2b-264" = 0xb221,
    @"blake2b-272" = 0xb222,
    @"blake2b-280" = 0xb223,
    @"blake2b-288" = 0xb224,
    @"blake2b-296" = 0xb225,
    @"blake2b-304" = 0xb226,
    @"blake2b-312" = 0xb227,
    @"blake2b-320" = 0xb228,
    @"blake2b-328" = 0xb229,
    @"blake2b-336" = 0xb22a,
    @"blake2b-344" = 0xb22b,
    @"blake2b-352" = 0xb22c,
    @"blake2b-360" = 0xb22d,
    @"blake2b-368" = 0xb22e,
    @"blake2b-376" = 0xb22f,
    @"blake2b-384" = 0xb230,
    @"blake2b-392" = 0xb231,
    @"blake2b-400" = 0xb232,
    @"blake2b-408" = 0xb233,
    @"blake2b-416" = 0xb234,
    @"blake2b-424" = 0xb235,
    @"blake2b-432" = 0xb236,
    @"blake2b-440" = 0xb237,
    @"blake2b-448" = 0xb238,
    @"blake2b-456" = 0xb239,
    @"blake2b-464" = 0xb23a,
    @"blake2b-472" = 0xb23b,
    @"blake2b-480" = 0xb23c,
    @"blake2b-488" = 0xb23d,
    @"blake2b-496" = 0xb23e,
    @"blake2b-504" = 0xb23f,
    @"blake2b-512" = 0xb240,
    @"blake2s-8" = 0xb241,
    @"blake2s-16" = 0xb242,
    @"blake2s-24" = 0xb243,
    @"blake2s-32" = 0xb244,
    @"blake2s-40" = 0xb245,
    @"blake2s-48" = 0xb246,
    @"blake2s-56" = 0xb247,
    @"blake2s-64" = 0xb248,
    @"blake2s-72" = 0xb249,
    @"blake2s-80" = 0xb24a,
    @"blake2s-88" = 0xb24b,
    @"blake2s-96" = 0xb24c,
    @"blake2s-104" = 0xb24d,
    @"blake2s-112" = 0xb24e,
    @"blake2s-120" = 0xb24f,
    @"blake2s-128" = 0xb250,
    @"blake2s-136" = 0xb251,
    @"blake2s-144" = 0xb252,
    @"blake2s-152" = 0xb253,
    @"blake2s-160" = 0xb254,
    @"blake2s-168" = 0xb255,
    @"blake2s-176" = 0xb256,
    @"blake2s-184" = 0xb257,
    @"blake2s-192" = 0xb258,
    @"blake2s-200" = 0xb259,
    @"blake2s-208" = 0xb25a,
    @"blake2s-216" = 0xb25b,
    @"blake2s-224" = 0xb25c,
    @"blake2s-232" = 0xb25d,
    @"blake2s-240" = 0xb25e,
    @"blake2s-248" = 0xb25f,
    @"blake2s-256" = 0xb260,
    @"skein256-8" = 0xb301,
    @"skein256-16" = 0xb302,
    @"skein256-24" = 0xb303,
    @"skein256-32" = 0xb304,
    @"skein256-40" = 0xb305,
    @"skein256-48" = 0xb306,
    @"skein256-56" = 0xb307,
    @"skein256-64" = 0xb308,
    @"skein256-72" = 0xb309,
    @"skein256-80" = 0xb30a,
    @"skein256-88" = 0xb30b,
    @"skein256-96" = 0xb30c,
    @"skein256-104" = 0xb30d,
    @"skein256-112" = 0xb30e,
    @"skein256-120" = 0xb30f,
    @"skein256-128" = 0xb310,
    @"skein256-136" = 0xb311,
    @"skein256-144" = 0xb312,
    @"skein256-152" = 0xb313,
    @"skein256-160" = 0xb314,
    @"skein256-168" = 0xb315,
    @"skein256-176" = 0xb316,
    @"skein256-184" = 0xb317,
    @"skein256-192" = 0xb318,
    @"skein256-200" = 0xb319,
    @"skein256-208" = 0xb31a,
    @"skein256-216" = 0xb31b,
    @"skein256-224" = 0xb31c,
    @"skein256-232" = 0xb31d,
    @"skein256-240" = 0xb31e,
    @"skein256-248" = 0xb31f,
    @"skein256-256" = 0xb320,
    @"skein512-8" = 0xb321,
    @"skein512-16" = 0xb322,
    @"skein512-24" = 0xb323,
    @"skein512-32" = 0xb324,
    @"skein512-40" = 0xb325,
    @"skein512-48" = 0xb326,
    @"skein512-56" = 0xb327,
    @"skein512-64" = 0xb328,
    @"skein512-72" = 0xb329,
    @"skein512-80" = 0xb32a,
    @"skein512-88" = 0xb32b,
    @"skein512-96" = 0xb32c,
    @"skein512-104" = 0xb32d,
    @"skein512-112" = 0xb32e,
    @"skein512-120" = 0xb32f,
    @"skein512-128" = 0xb330,
    @"skein512-136" = 0xb331,
    @"skein512-144" = 0xb332,
    @"skein512-152" = 0xb333,
    @"skein512-160" = 0xb334,
    @"skein512-168" = 0xb335,
    @"skein512-176" = 0xb336,
    @"skein512-184" = 0xb337,
    @"skein512-192" = 0xb338,
    @"skein512-200" = 0xb339,
    @"skein512-208" = 0xb33a,
    @"skein512-216" = 0xb33b,
    @"skein512-224" = 0xb33c,
    @"skein512-232" = 0xb33d,
    @"skein512-240" = 0xb33e,
    @"skein512-248" = 0xb33f,
    @"skein512-256" = 0xb340,
    @"skein512-264" = 0xb341,
    @"skein512-272" = 0xb342,
    @"skein512-280" = 0xb343,
    @"skein512-288" = 0xb344,
    @"skein512-296" = 0xb345,
    @"skein512-304" = 0xb346,
    @"skein512-312" = 0xb347,
    @"skein512-320" = 0xb348,
    @"skein512-328" = 0xb349,
    @"skein512-336" = 0xb34a,
    @"skein512-344" = 0xb34b,
    @"skein512-352" = 0xb34c,
    @"skein512-360" = 0xb34d,
    @"skein512-368" = 0xb34e,
    @"skein512-376" = 0xb34f,
    @"skein512-384" = 0xb350,
    @"skein512-392" = 0xb351,
    @"skein512-400" = 0xb352,
    @"skein512-408" = 0xb353,
    @"skein512-416" = 0xb354,
    @"skein512-424" = 0xb355,
    @"skein512-432" = 0xb356,
    @"skein512-440" = 0xb357,
    @"skein512-448" = 0xb358,
    @"skein512-456" = 0xb359,
    @"skein512-464" = 0xb35a,
    @"skein512-472" = 0xb35b,
    @"skein512-480" = 0xb35c,
    @"skein512-488" = 0xb35d,
    @"skein512-496" = 0xb35e,
    @"skein512-504" = 0xb35f,
    @"skein512-512" = 0xb360,
    @"skein1024-8" = 0xb361,
    @"skein1024-16" = 0xb362,
    @"skein1024-24" = 0xb363,
    @"skein1024-32" = 0xb364,
    @"skein1024-40" = 0xb365,
    @"skein1024-48" = 0xb366,
    @"skein1024-56" = 0xb367,
    @"skein1024-64" = 0xb368,
    @"skein1024-72" = 0xb369,
    @"skein1024-80" = 0xb36a,
    @"skein1024-88" = 0xb36b,
    @"skein1024-96" = 0xb36c,
    @"skein1024-104" = 0xb36d,
    @"skein1024-112" = 0xb36e,
    @"skein1024-120" = 0xb36f,
    @"skein1024-128" = 0xb370,
    @"skein1024-136" = 0xb371,
    @"skein1024-144" = 0xb372,
    @"skein1024-152" = 0xb373,
    @"skein1024-160" = 0xb374,
    @"skein1024-168" = 0xb375,
    @"skein1024-176" = 0xb376,
    @"skein1024-184" = 0xb377,
    @"skein1024-192" = 0xb378,
    @"skein1024-200" = 0xb379,
    @"skein1024-208" = 0xb37a,
    @"skein1024-216" = 0xb37b,
    @"skein1024-224" = 0xb37c,
    @"skein1024-232" = 0xb37d,
    @"skein1024-240" = 0xb37e,
    @"skein1024-248" = 0xb37f,
    @"skein1024-256" = 0xb380,
    @"skein1024-264" = 0xb381,
    @"skein1024-272" = 0xb382,
    @"skein1024-280" = 0xb383,
    @"skein1024-288" = 0xb384,
    @"skein1024-296" = 0xb385,
    @"skein1024-304" = 0xb386,
    @"skein1024-312" = 0xb387,
    @"skein1024-320" = 0xb388,
    @"skein1024-328" = 0xb389,
    @"skein1024-336" = 0xb38a,
    @"skein1024-344" = 0xb38b,
    @"skein1024-352" = 0xb38c,
    @"skein1024-360" = 0xb38d,
    @"skein1024-368" = 0xb38e,
    @"skein1024-376" = 0xb38f,
    @"skein1024-384" = 0xb390,
    @"skein1024-392" = 0xb391,
    @"skein1024-400" = 0xb392,
    @"skein1024-408" = 0xb393,
    @"skein1024-416" = 0xb394,
    @"skein1024-424" = 0xb395,
    @"skein1024-432" = 0xb396,
    @"skein1024-440" = 0xb397,
    @"skein1024-448" = 0xb398,
    @"skein1024-456" = 0xb399,
    @"skein1024-464" = 0xb39a,
    @"skein1024-472" = 0xb39b,
    @"skein1024-480" = 0xb39c,
    @"skein1024-488" = 0xb39d,
    @"skein1024-496" = 0xb39e,
    @"skein1024-504" = 0xb39f,
    @"skein1024-512" = 0xb3a0,
    @"skein1024-520" = 0xb3a1,
    @"skein1024-528" = 0xb3a2,
    @"skein1024-536" = 0xb3a3,
    @"skein1024-544" = 0xb3a4,
    @"skein1024-552" = 0xb3a5,
    @"skein1024-560" = 0xb3a6,
    @"skein1024-568" = 0xb3a7,
    @"skein1024-576" = 0xb3a8,
    @"skein1024-584" = 0xb3a9,
    @"skein1024-592" = 0xb3aa,
    @"skein1024-600" = 0xb3ab,
    @"skein1024-608" = 0xb3ac,
    @"skein1024-616" = 0xb3ad,
    @"skein1024-624" = 0xb3ae,
    @"skein1024-632" = 0xb3af,
    @"skein1024-640" = 0xb3b0,
    @"skein1024-648" = 0xb3b1,
    @"skein1024-656" = 0xb3b2,
    @"skein1024-664" = 0xb3b3,
    @"skein1024-672" = 0xb3b4,
    @"skein1024-680" = 0xb3b5,
    @"skein1024-688" = 0xb3b6,
    @"skein1024-696" = 0xb3b7,
    @"skein1024-704" = 0xb3b8,
    @"skein1024-712" = 0xb3b9,
    @"skein1024-720" = 0xb3ba,
    @"skein1024-728" = 0xb3bb,
    @"skein1024-736" = 0xb3bc,
    @"skein1024-744" = 0xb3bd,
    @"skein1024-752" = 0xb3be,
    @"skein1024-760" = 0xb3bf,
    @"skein1024-768" = 0xb3c0,
    @"skein1024-776" = 0xb3c1,
    @"skein1024-784" = 0xb3c2,
    @"skein1024-792" = 0xb3c3,
    @"skein1024-800" = 0xb3c4,
    @"skein1024-808" = 0xb3c5,
    @"skein1024-816" = 0xb3c6,
    @"skein1024-824" = 0xb3c7,
    @"skein1024-832" = 0xb3c8,
    @"skein1024-840" = 0xb3c9,
    @"skein1024-848" = 0xb3ca,
    @"skein1024-856" = 0xb3cb,
    @"skein1024-864" = 0xb3cc,
    @"skein1024-872" = 0xb3cd,
    @"skein1024-880" = 0xb3ce,
    @"skein1024-888" = 0xb3cf,
    @"skein1024-896" = 0xb3d0,
    @"skein1024-904" = 0xb3d1,
    @"skein1024-912" = 0xb3d2,
    @"skein1024-920" = 0xb3d3,
    @"skein1024-928" = 0xb3d4,
    @"skein1024-936" = 0xb3d5,
    @"skein1024-944" = 0xb3d6,
    @"skein1024-952" = 0xb3d7,
    @"skein1024-960" = 0xb3d8,
    @"skein1024-968" = 0xb3d9,
    @"skein1024-976" = 0xb3da,
    @"skein1024-984" = 0xb3db,
    @"skein1024-992" = 0xb3dc,
    @"skein1024-1000" = 0xb3dd,
    @"skein1024-1008" = 0xb3de,
    @"skein1024-1016" = 0xb3df,
    @"skein1024-1024" = 0xb3e0,
    @"xxh-32" = 0xb3e1,
    @"xxh-64" = 0xb3e2,
    @"xxh3-64" = 0xb3e3,
    @"xxh3-128" = 0xb3e4,
    @"poseidon-bls12_381-a2-fc1" = 0xb401,
    @"poseidon-bls12_381-a2-fc1-sc" = 0xb402,
    @"rdfc-1" = 0xb403,
    @"ssz" = 0xb501,
    @"ssz-sha2-256-bmt" = 0xb502,
    @"sha2-256-chunked" = 0xb510,
    @"json-jcs" = 0xb601,
    @"iscc" = 0xcc01,
    @"zeroxcert-imprint-256" = 0xce11,
    @"nonstandard-sig" = 0xd000,
    @"bcrypt-pbkdf" = 0xd00d,
    @"es256k" = 0xd0e7,
    @"bls12_381-g1-sig" = 0xd0ea,
    @"bls12_381-g2-sig" = 0xd0eb,
    @"eddsa" = 0xd0ed,
    @"eip-191" = 0xd191,
    @"jwk_jcs-pub" = 0xeb51,
    @"fil-commitment-unsealed" = 0xf101,
    @"fil-commitment-sealed" = 0xf102,
    @"plaintextv2" = 0x706c61,
    @"holochain-adr-v0" = 0x807124,
    @"holochain-adr-v1" = 0x817124,
    @"holochain-key-v0" = 0x947124,
    @"holochain-key-v1" = 0x957124,
    @"holochain-sig-v0" = 0xa27124,
    @"holochain-sig-v1" = 0xa37124,
    @"skynet-ns" = 0xb19910,
    @"arweave-ns" = 0xb29910,
    @"subspace-ns" = 0xb39910,
    @"kumandra-ns" = 0xb49910,
    @"es256" = 0xd01200,
    @"es284" = 0xd01201,
    @"es512" = 0xd01202,
    @"rs256" = 0xd01205,
    @"es256k-msig" = 0xd01300,
    @"bls12_381-g1-msig" = 0xd01301,
    @"bls12_381-g2-msig" = 0xd01302,
    @"eddsa-msig" = 0xd01303,
    @"bls12_381-g1-share-msig" = 0xd01304,
    @"bls12_381-g2-share-msig" = 0xd01305,
    @"lamport-msig" = 0xd01306,
    @"lamport-share-msig" = 0xd01307,
    @"es256-msig" = 0xd01308,
    @"es384-msig" = 0xd01309,
    @"es521-msig" = 0xd0130a,
    @"rs256-msig" = 0xd0130b,
    @"scion" = 0xd02000,
    _,
    // zig fmt: on

    pub fn encodingLength(codec: Codec) usize {
        return varint.encodingLength(@intCast(@intFromEnum(codec)));
    }

    pub fn decode(buf: []const u8, len: ?*usize) !Codec {
        const val = try varint.decode(buf, len);
        return try fromCode(val);
    }

    pub fn read(reader: std.io.AnyReader) !Codec {
        const val = try varint.read(reader);
        return try fromCode(val);
    }

    inline fn fromCode(val: u64) !Codec {
        if (val > std.math.maxInt(u32)) {
            return error.INVALID_MULTICODEC;
        }

        const code: u32 = @intCast(val);
        return @enumFromInt(code);
    }

    pub fn encode(codec: Codec, buf: []const u8) usize {
        return varint.encode(buf, @intFromEnum(codec));
    }

    pub fn write(codec: Codec, writer: std.io.AnyWriter) !void {
        try varint.write(writer, @intFromEnum(codec));
    }
};
