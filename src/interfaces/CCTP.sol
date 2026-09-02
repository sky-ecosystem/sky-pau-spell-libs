// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.34;

interface ICCTPFacet {

    function VERSION() external pure returns (string memory);

    function DESTINATION_CALLER() external pure returns (bytes32);

    function MIN_FINALITY_THRESHOLD() external pure returns (uint32);

    function cctp() external view returns (address);

    function usdc() external view returns (address);

    function setDomainParameters(
        uint32  destinationDomain,
        bytes32 recipient,
        uint32  minFeeCapRate,
        uint32  maxFeeCapRate
    ) external;

    function transfer(uint256 usdcAmount, uint32 destinationDomain, uint64 feeCapRate) external;

    function toCCTPRateLimitKey() external pure returns (bytes32 key);

    function getDomainParameters(uint32 destinationDomain)
        external
        view
        returns (bytes32 mintRecipient, uint32 minFeeCapRate, uint32 maxFeeCapRate);

    function getToDomainRateLimitKey(uint32 destinationDomain)
        external
        pure
        returns (bytes32 key);

}

interface ICCTPController {

    function cctp_VERSION() external pure returns (string memory);

    function cctp_DESTINATION_CALLER() external pure returns (bytes32);

    function cctp_MIN_FINALITY_THRESHOLD() external pure returns (uint32);

    function cctp_cctp() external view returns (address);

    function cctp_usdc() external view returns (address);

    function cctp_setDomainParameters(
        uint32  destinationDomain,
        bytes32 recipient,
        uint32  minFeeCapRate,
        uint32  maxFeeCapRate
    ) external;

    function cctp_transfer(uint256 usdcAmount, uint32 destinationDomain, uint64 feeCapRate)
        external;

    function cctp_toCCTPRateLimitKey() external pure returns (bytes32 key);

    function cctp_getDomainParameters(uint32 destinationDomain)
        external
        view
        returns (bytes32 mintRecipient, uint32 minFeeCapRate, uint32 maxFeeCapRate);

    function cctp_getToDomainRateLimitKey(uint32 destinationDomain)
        external
        pure
        returns (bytes32 key);

}
