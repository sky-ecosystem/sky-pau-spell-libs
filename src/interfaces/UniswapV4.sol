// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.34;

struct PoolKey {
    address currency0;
    address currency1;
    uint24  fee;
    int24   tickSpacing;
    address hooks;
}

struct TickLimits {
    int24  tickLowerMin;
    int24  tickUpperMax;
    uint24 maxTickSpacing;
}

interface IUniswapV4Facet {

    function VERSION() external pure returns (string memory);

    function permit2() external view returns (address);

    function positionManager() external view returns (address);

    function router() external view returns (address);

    function decreasePosition(
        bytes32 poolId,
        uint256 tokenId,
        uint128 liquidityDecrease,
        uint128 amount0Min,
        uint128 amount1Min
    )
        external;

    function increasePosition(
        bytes32 poolId,
        uint256 tokenId,
        uint128 liquidityIncrease,
        uint128 amount0Max,
        uint128 amount1Max
    )
        external;

    function mintPosition(
        bytes32 poolId,
        int24   tickLower,
        int24   tickUpper,
        uint128 liquidity,
        uint128 amount0Max,
        uint128 amount1Max
    )
        external;

    function setMaxSlippage(bytes32 poolId, uint256 maxSlippage) external;

    function setTickLimits(
        bytes32 poolId,
        int24   tickLowerMin,
        int24   tickUpperMax,
        uint24  maxTickSpacing
    )
        external;

    function swap(
        PoolKey calldata poolKey,
        address          tokenIn,
        uint128          amountIn,
        uint128          amountOutMin
    )
        external;

    function getAggregateDepositRateLimitKey(bytes32 poolId) external pure returns (bytes32 key);

    function getAssetDepositRateLimitKey(bytes32 poolId, address token)
        external
        pure
        returns (bytes32 key);

    function getMaxSlippage(bytes32 poolId) external view returns (uint256 maxSlippage);

    function getSwapRateLimitKey(bytes32 poolId, address token) external pure returns (bytes32 key);

    function getTickLimits(bytes32 poolId)
        external
        view
        returns (int24 tickLowerMin, int24 tickUpperMax, uint24 maxTickSpacing);

    function getAggregateWithdrawRateLimitKey(bytes32 poolId) external pure returns (bytes32 key);

    function getAssetWithdrawRateLimitKey(bytes32 poolId, address token)
        external
        pure
        returns (bytes32 key);

}

interface IUniswapV4Controller {

    function uniswapV4_VERSION() external pure returns (string memory);

    function uniswapV4_permit2() external view returns (address);

    function uniswapV4_positionManager() external view returns (address);

    function uniswapV4_router() external view returns (address);

    function uniswapV4_setMaxSlippage(bytes32 poolId, uint256 maxSlippage) external;

    function uniswapV4_setTickLimits(
        bytes32 poolId,
        int24   tickLowerMin,
        int24   tickUpperMax,
        uint24  maxTickSpacing
    )
        external;

    function uniswapV4_mintPosition(
        bytes32 poolId,
        int24   tickLower,
        int24   tickUpper,
        uint128 liquidity,
        uint128 amount0Max,
        uint128 amount1Max
    )
        external;

    function uniswapV4_increasePosition(
        bytes32 poolId,
        uint256 tokenId,
        uint128 liquidityIncrease,
        uint128 amount0Max,
        uint128 amount1Max
    )
        external;

    function uniswapV4_decreasePosition(
        bytes32 poolId,
        uint256 tokenId,
        uint128 liquidityDecrease,
        uint128 amount0Min,
        uint128 amount1Min
    )
        external;

    function uniswapV4_swap(
        PoolKey calldata poolKey,
        address          tokenIn,
        uint128          amountIn,
        uint128          amountOutMin
    )
        external;

    function uniswapV4_getAggregateDepositRateLimitKey(bytes32 poolId)
        external
        pure
        returns (bytes32 key);

    function uniswapV4_getAssetDepositRateLimitKey(bytes32 poolId, address token)
        external
        pure
        returns (bytes32 key);

    function uniswapV4_getMaxSlippage(bytes32 poolId) external view returns (uint256);

    function uniswapV4_getSwapRateLimitKey(bytes32 poolId, address token)
        external
        pure
        returns (bytes32 key);

    function uniswapV4_getTickLimits(bytes32 poolId)
        external
        view
        returns (int24 tickLowerMin, int24 tickUpperMax, uint24 maxTickSpacing);

    function uniswapV4_getAggregateWithdrawRateLimitKey(bytes32 poolId)
        external
        pure
        returns (bytes32 key);

    function uniswapV4_getAssetWithdrawRateLimitKey(bytes32 poolId, address token)
        external
        pure
        returns (bytes32 key);

}
