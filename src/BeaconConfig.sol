// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.34;

import { IBeaconLike } from "./interfaces/IBeaconLike.sol";

import { ICCTPController,       ICCTPFacet }       from "./interfaces/CCTP.sol";
import { IERC4626Controller,    IERC4626Facet }    from "./interfaces/ERC4626.sol";
import { ILayerZeroController,  ILayerZeroFacet }  from "./interfaces/LayerZero.sol";
import { IPSM3Controller,       IPSM3Facet }       from "./interfaces/PSM3.sol";
import { ISparkVaultController, ISparkVaultFacet } from "./interfaces/SparkVault.sol";

/**
 * @title  BeaconConfig
 * @notice Library used by Sky Spells to configure and read facet integrations at a Sky Diamond PAU
 *         Beacon.
 * @dev    `set*Integration` functions must be executed by the beacon admin. For spell execution /
 *         broadcasting, calls should be wrapped in `vm.startBroadcast` and `vm.stopBroadcast`. For
 *         spell testing, calls should be wrapped in `vm.startPrank` and `vm.stopPrank`. The
 *         `get*Integration` functions are helper getters used in spell tests to assert that facet
 *         integrations and selector wires are configured correctly on the beacon.
 */
library BeaconConfig {

    /**********************************************************************************************/
    /*** Constants                                                                              ***/
    /**********************************************************************************************/

    /// @notice Integration identifier for the CCTP facet.
    bytes32 internal constant CCTP_INTEGRATION = "CCTP_FACET";

    /// @notice Integration identifier for the ERC-4626 facet.
    bytes32 internal constant ERC4626_INTEGRATION = "ERC4626_FACET";

    /// @notice Integration identifier for the LayerZero facet.
    bytes32 internal constant LAYER_ZERO_INTEGRATION = "LAYER_ZERO_FACET";

    /// @notice Integration identifier for the PSM3 facet.
    bytes32 internal constant PSM3_INTEGRATION = "PSM3_FACET";

    /// @notice Integration identifier for the Spark Vault facet.
    bytes32 internal constant SPARK_VAULT_INTEGRATION = "SPARK_VAULT_FACET";

    /**********************************************************************************************/
    /*** CCTP Integration                                                                       ***/
    /**********************************************************************************************/

    /**
     * @notice Configures the CCTP facet integration on the beacon.
     * @dev    Must be called by the beacon admin (e.g. wrapped in
     *         `vm.startBroadcast`/`vm.stopBroadcast` or `vm.startPrank`/`vm.stopPrank`).
     * @param  beacon Address of the Sky Diamond PAU Beacon.
     * @param  facet  Address of the deployed CCTPFacet contract.
     */
    function setCCTPIntegration(address beacon, address facet) internal {
        IBeaconLike.Wire[] memory wires = new IBeaconLike.Wire[](10);

        wires[0] = IBeaconLike.Wire(
            ICCTPController.cctp_setDomainParameters.selector,
            ICCTPFacet.setDomainParameters.selector
        );

        wires[1] = IBeaconLike.Wire(
            ICCTPController.cctp_transfer.selector,
            ICCTPFacet.transfer.selector
        );

        wires[2] = IBeaconLike.Wire(
            ICCTPController.cctp_toCCTPRateLimitKey.selector,
            ICCTPFacet.toCCTPRateLimitKey.selector
        );

        wires[3] = IBeaconLike.Wire(
            ICCTPController.cctp_getDomainParameters.selector,
            ICCTPFacet.getDomainParameters.selector
        );

        wires[4] = IBeaconLike.Wire(
            ICCTPController.cctp_getToDomainRateLimitKey.selector,
            ICCTPFacet.getToDomainRateLimitKey.selector
        );

        wires[5] = IBeaconLike.Wire(
            ICCTPController.cctp_VERSION.selector,
            ICCTPFacet.VERSION.selector
        );

        wires[6] = IBeaconLike.Wire(
            ICCTPController.cctp_DESTINATION_CALLER.selector,
            ICCTPFacet.DESTINATION_CALLER.selector
        );

        wires[7] = IBeaconLike.Wire(
            ICCTPController.cctp_MIN_FINALITY_THRESHOLD.selector,
            ICCTPFacet.MIN_FINALITY_THRESHOLD.selector
        );

        wires[8] = IBeaconLike.Wire(
            ICCTPController.cctp_cctp.selector,
            ICCTPFacet.cctp.selector
        );

        wires[9] = IBeaconLike.Wire(
            ICCTPController.cctp_usdc.selector,
            ICCTPFacet.usdc.selector
        );

        IBeaconLike.Config memory config = IBeaconLike.Config({
            facet : facet,
            wires : wires
        });

        IBeaconLike(beacon).setIntegration(CCTP_INTEGRATION, config);
    }

    /**
     * @notice Retrieves the CCTP facet integration configuration from the beacon.
     * @dev    Intended for spell testing to verify integration configuration was set correctly.
     * @param  beacon Address of the Sky Diamond PAU Beacon.
     * @return config Configuration struct containing the facet address and selector wires.
     */
    function getCCTPIntegration(address beacon) internal view returns (IBeaconLike.Config memory) {
        return IBeaconLike(beacon).getConfig(CCTP_INTEGRATION);
    }

    /**********************************************************************************************/
    /*** ERC4626 Integration                                                                    ***/
    /**********************************************************************************************/

    /**
     * @notice Configures the ERC4626 facet integration on the beacon.
     * @dev    Must be called by the beacon admin (e.g. wrapped in
     *         `vm.startBroadcast`/`vm.stopBroadcast` or `vm.startPrank`/`vm.stopPrank`).
     * @param  beacon Address of the Sky Diamond PAU Beacon.
     * @param  facet  Address of the deployed ERC4626Facet contract.
     */
    function setERC4626Integration(address beacon, address facet) internal {
        IBeaconLike.Wire[] memory wires = new IBeaconLike.Wire[](9);

        wires[0] = IBeaconLike.Wire(
            IERC4626Controller.erc4626_setMaxExchangeRate.selector,
            IERC4626Facet.setMaxExchangeRate.selector
        );

        wires[1] = IBeaconLike.Wire(
            IERC4626Controller.erc4626_deposit.selector,
            IERC4626Facet.deposit.selector
        );

        wires[2] = IBeaconLike.Wire(
            IERC4626Controller.erc4626_withdraw.selector,
            IERC4626Facet.withdraw.selector
        );

        wires[3] = IBeaconLike.Wire(
            IERC4626Controller.erc4626_redeem.selector,
            IERC4626Facet.redeem.selector
        );

        wires[4] = IBeaconLike.Wire(
            IERC4626Controller.erc4626_EXCHANGE_RATE_PRECISION.selector,
            IERC4626Facet.EXCHANGE_RATE_PRECISION.selector
        );

        wires[5] = IBeaconLike.Wire(
            IERC4626Controller.erc4626_getMaxExchangeRate.selector,
            IERC4626Facet.getMaxExchangeRate.selector
        );

        wires[6] = IBeaconLike.Wire(
            IERC4626Controller.erc4626_getDepositRateLimitKey.selector,
            IERC4626Facet.getDepositRateLimitKey.selector
        );

        wires[7] = IBeaconLike.Wire(
            IERC4626Controller.erc4626_getWithdrawRateLimitKey.selector,
            IERC4626Facet.getWithdrawRateLimitKey.selector
        );

        wires[8] = IBeaconLike.Wire(
            IERC4626Controller.erc4626_VERSION.selector,
            IERC4626Facet.VERSION.selector
        );

        IBeaconLike.Config memory config = IBeaconLike.Config({
            facet : facet,
            wires : wires
        });

        IBeaconLike(beacon).setIntegration(ERC4626_INTEGRATION, config);
    }

    /**
     * @notice Retrieves the ERC4626 facet integration configuration from the beacon.
     * @dev    Intended for spell testing to verify integration configuration was set correctly.
     * @param  beacon Address of the Sky Diamond PAU Beacon.
     * @return config Configuration struct containing the facet address and selector wires.
     */
    function getERC4626Integration(address beacon)
        internal
        view
        returns (IBeaconLike.Config memory)
    {
        return IBeaconLike(beacon).getConfig(ERC4626_INTEGRATION);
    }

    /**********************************************************************************************/
    /*** LayerZero Integration                                                                  ***/
    /**********************************************************************************************/

    /**
     * @notice Configures the LayerZero facet integration on the beacon.
     * @dev    Must be called by the beacon admin (e.g. wrapped in
     *         `vm.startBroadcast`/`vm.stopBroadcast` or `vm.startPrank`/`vm.stopPrank`).
     * @param  beacon Address of the Sky Diamond PAU Beacon.
     * @param  facet  Address of the deployed LayerZeroFacet contract.
     */
    function setLayerZeroIntegration(address beacon, address facet) internal {
        IBeaconLike.Wire[] memory wires = new IBeaconLike.Wire[](6);

        wires[0] = IBeaconLike.Wire(
            ILayerZeroController.layerZero_setRecipient.selector,
            ILayerZeroFacet.setRecipient.selector
        );

        wires[1] = IBeaconLike.Wire(
            ILayerZeroController.layerZero_transfer.selector,
            ILayerZeroFacet.transfer.selector
        );

        wires[2] = IBeaconLike.Wire(
            ILayerZeroController.layerZero_getRecipient.selector,
            ILayerZeroFacet.getRecipient.selector
        );

        wires[3] = IBeaconLike.Wire(
            ILayerZeroController.layerZero_getTransferRateLimitKey.selector,
            ILayerZeroFacet.getTransferRateLimitKey.selector
        );

        wires[4] = IBeaconLike.Wire(
            ILayerZeroController.layerZero_quoteTransfer.selector,
            ILayerZeroFacet.quoteTransfer.selector
        );

        wires[5] = IBeaconLike.Wire(
            ILayerZeroController.layerZero_VERSION.selector,
            ILayerZeroFacet.VERSION.selector
        );

        IBeaconLike.Config memory config = IBeaconLike.Config({
            facet : facet,
            wires : wires
        });

        IBeaconLike(beacon).setIntegration(LAYER_ZERO_INTEGRATION, config);
    }

    /**
     * @notice Retrieves the LayerZero facet integration configuration from the beacon.
     * @dev    Intended for spell testing to verify integration configuration was set correctly.
     * @param  beacon Address of the Sky Diamond PAU Beacon.
     * @return config Configuration struct containing the facet address and selector wires.
     */
    function getLayerZeroIntegration(address beacon)
        internal
        view
        returns (IBeaconLike.Config memory)
    {
        return IBeaconLike(beacon).getConfig(LAYER_ZERO_INTEGRATION);
    }

    /**********************************************************************************************/
    /*** PSM3 Integration                                                                       ***/
    /**********************************************************************************************/

    /**
     * @notice Configures the PSM3 facet integration on the beacon.
     * @dev    Must be called by the beacon admin (e.g. wrapped in
     *         `vm.startBroadcast`/`vm.stopBroadcast` or `vm.startPrank`/`vm.stopPrank`).
     * @param  beacon Address of the Sky Diamond PAU Beacon.
     * @param  facet  Address of the deployed PSM3Facet contract.
     */
    function setPSM3Integration(address beacon, address facet) internal {
        IBeaconLike.Wire[] memory wires = new IBeaconLike.Wire[](6);

        wires[0] = IBeaconLike.Wire(
            IPSM3Controller.psm3_deposit.selector,
            IPSM3Facet.deposit.selector
        );

        wires[1] = IBeaconLike.Wire(
            IPSM3Controller.psm3_withdraw.selector,
            IPSM3Facet.withdraw.selector
        );

        wires[2] = IBeaconLike.Wire(
            IPSM3Controller.psm3_getDepositRateLimitKey.selector,
            IPSM3Facet.getDepositRateLimitKey.selector
        );

        wires[3] = IBeaconLike.Wire(
            IPSM3Controller.psm3_getWithdrawRateLimitKey.selector,
            IPSM3Facet.getWithdrawRateLimitKey.selector
        );

        wires[4] = IBeaconLike.Wire(
            IPSM3Controller.psm3_VERSION.selector,
            IPSM3Facet.VERSION.selector
        );

        wires[5] = IBeaconLike.Wire(
            IPSM3Controller.psm3_psm.selector,
            IPSM3Facet.psm.selector
        );

        IBeaconLike.Config memory config = IBeaconLike.Config({
            facet : facet,
            wires : wires
        });

        IBeaconLike(beacon).setIntegration(PSM3_INTEGRATION, config);
    }

    /**
     * @notice Retrieves the PSM3 facet integration configuration from the beacon.
     * @dev    Intended for spell testing to verify integration configuration was set correctly.
     * @param  beacon Address of the Sky Diamond PAU Beacon.
     * @return config Configuration struct containing the facet address and selector wires.
     */
    function getPSM3Integration(address beacon)
        internal
        view
        returns (IBeaconLike.Config memory)
    {
        return IBeaconLike(beacon).getConfig(PSM3_INTEGRATION);
    }

    /**********************************************************************************************/
    /*** SparkVault Integration                                                                 ***/
    /**********************************************************************************************/

    /**
     * @notice Configures the SparkVault facet integration on the beacon.
     * @dev    Must be called by the beacon admin (e.g. wrapped in
     *         `vm.startBroadcast`/`vm.stopBroadcast` or `vm.startPrank`/`vm.stopPrank`).
     * @param  beacon Address of the Sky Diamond PAU Beacon.
     * @param  facet  Address of the deployed SparkVaultFacet contract.
     */
    function setSparkVaultIntegration(address beacon, address facet) internal {
        IBeaconLike.Wire[] memory wires = new IBeaconLike.Wire[](3);

        wires[0] = IBeaconLike.Wire(
            ISparkVaultController.sparkVault_take.selector,
            ISparkVaultFacet.take.selector
        );

        wires[1] = IBeaconLike.Wire(
            ISparkVaultController.sparkVault_getTakeRateLimitKey.selector,
            ISparkVaultFacet.getTakeRateLimitKey.selector
        );

        wires[2] = IBeaconLike.Wire(
            ISparkVaultController.sparkVault_VERSION.selector,
            ISparkVaultFacet.VERSION.selector
        );

        IBeaconLike.Config memory config = IBeaconLike.Config({
            facet : facet,
            wires : wires
        });

        IBeaconLike(beacon).setIntegration(SPARK_VAULT_INTEGRATION, config);
    }

    /**
     * @notice Retrieves the SparkVault facet integration configuration from the beacon.
     * @dev    Intended for spell testing to verify integration configuration was set correctly.
     * @param  beacon Address of the Sky Diamond PAU Beacon.
     * @return config Configuration struct containing the facet address and selector wires.
     */
    function getSparkVaultIntegration(address beacon)
        internal
        view
        returns (IBeaconLike.Config memory)
    {
        return IBeaconLike(beacon).getConfig(SPARK_VAULT_INTEGRATION);
    }

}
