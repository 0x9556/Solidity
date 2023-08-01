import { EtherscanProvider, JsonRpcProvider } from 'ethers'

async function main() {
    const network = {
        name: 'Ethereum Mainnet',
        chainId: 1
    }

    const provider = new JsonRpcProvider(
        'https://mainnet.infura.io/v3/d03da06b40f946b8a99b05b324fdd42c',
        network
    )

    const gaugeContract = await new EtherscanProvider().getContract(
        '0x2F50D538606Fa9EDD2B11E2446BEb18C9D5846bB'
    )

    const data1 = gaugeContract?.interface.encodeFunctionData(
        'vote_for_gauge_weights',
        ['0x85D44861D024CB7603Ba906F2Dc9569fC02083F6', 1]
    )

    const data2 = gaugeContract?.interface.encodeFunctionData(
        'vote_for_gauge_weights',
        ['0x1cEBdB0856dd985fAe9b8fEa2262469360B8a3a6', 0]
    )

    const tx = {
        from: '0x7803Ab56769dDa5432CDbd63749a6BEeb3180008',
        to: await gaugeContract?.getAddress(),
        data: data1
    }

    const txn = await provider.call(tx)

    console.log(txn)
}

main()
