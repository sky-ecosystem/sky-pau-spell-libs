// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.34;

interface IAaveFacet {

    function VERSION() external pure returns (string memory);

    function deposit(address aToken, uint256 amount) external;

    function setMaxSlippage(address aToken, uint256 maxSlippage) external;

    function withdraw(address aToken, uint256 amount) external returns (uint256 amountWithdrawn);

    function getDepositRateLimitKey(address aToken, address pool, address underlyingAsset)
        external
        pure
        returns (bytes32 key);

    function getMaxSlippage(address aToken) external view returns (uint256 maxSlippage);

    function getWithdrawRateLimitKey(address aToken, address pool)
        external
        pure
        returns (bytes32 key);

}

interface IAaveController {

    function aave_VERSION() external pure returns (string memory);

    function aave_setMaxSlippage(address aToken, uint256 maxSlippage) external;

    function aave_deposit(address aToken, uint256 amount) external;

    function aave_withdraw(address aToken, uint256 amount)
        external
        returns (uint256 amountWithdrawn);

    function aave_getMaxSlippage(address aToken) external view returns (uint256);

    function aave_getDepositRateLimitKey(address aToken, address pool, address underlyingAsset)
        external
        pure
        returns (bytes32 key);

    function aave_getWithdrawRateLimitKey(address aToken, address pool)
        external
        pure
        returns (bytes32 key);

}
