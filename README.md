# Sky PAU Spell Libs

A collection of helper libraries intended to be used by Sky Spells to configure and verify facet integrations on a [Sky Diamond PAU](https://github.com/sky-ecosystem/diamond-pau) Beacon.

## Overview

The `BeaconConfig` library provides helper functions to wire selector dispatches and register facet configurations with a Sky Diamond PAU Beacon (`IBeaconLike`), as well as getter utilities for assertions during Spell testing.

### Supported Integrations

| Integration ID         | Facet                | Set Function                                 | Get Function                          |
| :--------------------- | :------------------- | :------------------------------------------- | :------------------------------------ |
| `AAVE_FACET`           | `AaveFacet`          | `setAaveIntegration(beacon, facet)`          | `getAaveIntegration(beacon)`          |
| `CCTP_FACET`           | `CCTPFacet`          | `setCCTPIntegration(beacon, facet)`          | `getCCTPIntegration(beacon)`          |
| `ERC4626_FACET`        | `ERC4626Facet`       | `setERC4626Integration(beacon, facet)`       | `getERC4626Integration(beacon)`       |
| `LAYER_ZERO_FACET`     | `LayerZeroFacet`     | `setLayerZeroIntegration(beacon, facet)`     | `getLayerZeroIntegration(beacon)`     |
| `PSM3_FACET`           | `PSM3Facet`          | `setPSM3Integration(beacon, facet)`          | `getPSM3Integration(beacon)`          |
| `SPARK_VAULT_FACET`    | `SparkVaultFacet`    | `setSparkVaultIntegration(beacon, facet)`    | `getSparkVaultIntegration(beacon)`    |
| `TRANSFER_ASSET_FACET` | `TransferAssetFacet` | `setTransferAssetIntegration(beacon, facet)` | `getTransferAssetIntegration(beacon)` |
| `UNISWAP_V4_FACET`     | `UniswapV4Facet`     | `setUniswapV4Integration(beacon, facet)`     | `getUniswapV4Integration(beacon)`     |

## Usage

### In Sky Spells (Broadcasting)

When broadcasting transactions in a Sky Spell script, calls to the `set*Integration` functions must be executed by the beacon admin and wrapped in `vm.startBroadcast` / `vm.stopBroadcast`:

```solidity
import { BeaconConfig } from "sky-pau-spell-libs/BeaconConfig.sol";

contract SkySpell {
    function execute(address beacon, address facet) external {
        address beaconAdmin = ...;

        vm.startBroadcast(beaconAdmin);
        BeaconConfig.setCCTPIntegration(beacon, facet);
        vm.stopBroadcast();
    }
}
```

### In Spell Testing

When testing Spells, calls to `set*Integration` functions should be executed under `vm.startPrank` / `vm.stopPrank` from the beacon admin. The `get*Integration` functions can then be used to pull configurations directly from the beacon to assert that the facet address and selector wires were registered correctly:

```solidity
import { BeaconConfig } from "sky-pau-spell-libs/BeaconConfig.sol";
import { IBeaconLike } from "sky-pau-spell-libs/interfaces/IBeaconLike.sol";

contract SkySpellTest is Test {
    function test_setIntegration() public {
        address beaconAdmin = ...;

        vm.startPrank(beaconAdmin);
        BeaconConfig.setCCTPIntegration(beacon, facet);
        vm.stopPrank();

        IBeaconLike.Config memory config = BeaconConfig.getCCTPIntegration(beacon);
        assertEq(config.facet, facet);
        assertEq(config.wires.length, 10);
    }
}
```

## Learn More

To learn more about the Sky Diamond PAU architecture, visit the [Sky Diamond PAU repository](https://github.com/sky-ecosystem/diamond-pau).

## Build

```bash
forge build
```

---

_The IP in this repository was assigned to Mars SPC Limited in respect of the MarsOne SP_
