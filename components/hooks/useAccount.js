import { useEffect } from "react";
import useSWR, { useSWRConfig } from "swr";

const useAccount = ({ web3, provider }) => {
  const { mutate } = useSWRConfig();
  const fetcher = async () => {
    const accounts = await web3.eth.getAccounts();
    const account = accounts[0] ?? null;

    if (!account) throw new Error('Cannot retrieve an account.');
    return account;
  };

  const { data, ...swrResponse } = useSWR(
    web3 ? "web3/Accounts" : null,
    fetcher
  );

  useEffect(() => {
    provider?.on('accountsChanged', () => mutate("web3/Accounts"))
  }, [provider, mutate]);

  return {
    data,
    ...swrResponse,
  };
};

export default useAccount;
