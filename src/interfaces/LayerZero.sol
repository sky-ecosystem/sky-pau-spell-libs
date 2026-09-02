// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.34;

struct MessagingFee {
    uint256 nativeFee;
    uint256 lzTokenFee;
}

struct SendParam {
    uint32  dstEid;
    bytes32 to;
    uint256 amountLD;
    uint256 minAmountLD;
    bytes   extraOptions;
    bytes   composeMsg;
    bytes   oftCmd;
}

interface ILayerZeroFacet {

    function VERSION() external pure returns (string memory);

    function setRecipient(uint32 destinationEndpointId, bytes32 recipient) external;

    function transfer(address oft, uint256 amount, uint32 destinationEndpointId) external payable;

    function getRecipient(uint32 destinationEndpointId) external view returns (bytes32 recipient);

    function getTransferRateLimitKey(
        address oft,
        bytes32 peer,
        uint32  destinationEndpointId,
        address token
    )
        external
        pure
        returns (bytes32 key);

    function quoteTransfer(address oft, uint256 amount, uint32 destinationEndpointId)
        external
        view
        returns (
            SendParam    memory sendParams,
            MessagingFee memory fee
        );

}

interface ILayerZeroController {

    function layerZero_VERSION() external pure returns (string memory);

    function layerZero_setRecipient(uint32 destinationEndpointId, bytes32 recipient) external;

    function layerZero_transfer(address oft, uint256 amount, uint32 destinationEndpointId)
        external
        payable;

    function layerZero_getRecipient(uint32 destinationEndpointId) external view returns (bytes32);

    function layerZero_getTransferRateLimitKey(
        address oft,
        bytes32 peer,
        uint32  destinationEndpointId,
        address token
    )
        external
        pure
        returns (bytes32 key);

    function layerZero_quoteTransfer(address oft, uint256 amount, uint32 destinationEndpointId)
        external
        view
        returns (
            SendParam    memory sendParams,
            MessagingFee memory fee
        );

}
