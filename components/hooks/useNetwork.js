import { useEffect } from "react";
import useSWR, { useSWRConfig } from "swr";

const NETWORKS = {
  1: "Ethereum Main Network (Mainnet)",
  3: "Ropsten Test Network",
  4: "Rinkeby Test Network",
  5: "Goerli Test Network",
  42: "Kovan Test Network",
  56: "Binance Smart Chain",
  5777: "Ganache",
};

const useNetwork = ({ web3, provider }) => {
  const { mutate } = useSWRConfig();
  const fetcher = async () => {
    const networkId = await web3.eth.net.getId();

    if (!networkId) throw new Error("Cannot retrieve network id!");

    return { networkId, networkName: NETWORKS[networkId] };
  };

  const { data, ...swrResponse } = useSWR(
    web3 ? "web3/Networks" : null,
    fetcher
  );

  useEffect(() => {
    provider?.on("chainChanged", () => mutate("web3/Networks"));
  }, [provider, mutate]);

  return { ...data, ...swrResponse };
};

export default useNetwork;
