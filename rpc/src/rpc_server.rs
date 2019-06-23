// TODO: panic handler
use std::io;
use std::net::SocketAddr;
use susy_jsonrpc_core;
use susy_jsonrpc_http_server::{self, ServerBuilder, Server, Host};

/// Start http server asynchronously and returns result with `Server` handle on success or an error.
pub fn start_http<M: susy_jsonrpc_core::Metadata>(
	addr: &SocketAddr,
	cors_domains: Option<Vec<String>>,
	allowed_hosts: Option<Vec<String>>,
	handler: susy_jsonrpc_core::MetaIoHandler<M>,
	) -> Result<Server, io::Error> {

	let cors_domains = cors_domains.map(|domains| {
		domains.into_iter()
			.map(|v| match v.as_str() {
				"*" => susy_jsonrpc_http_server::AccessControlAllowOrigin::Any,
				"null" => susy_jsonrpc_http_server::AccessControlAllowOrigin::Null,
				v => susy_jsonrpc_http_server::AccessControlAllowOrigin::Value(v.into()),
			})
			.collect()
	});

	ServerBuilder::new(handler)
		.cors(cors_domains.into())
		.allowed_hosts(allowed_hosts.map(|hosts| hosts.into_iter().map(Host::from).collect()).into())
		.start_http(addr)
}
