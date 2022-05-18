#define _CRT_SECURE_NO_WARNINGS

#include "include/flutter_ip_adapter_info/flutter_ip_adapter_info_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

// For getPlatformVersion; remove unless needed for your plugin implementation.
#include <VersionHelpers.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <Iphlpapi.h>

#include <map>
#include <vector>
#include <memory>
#include <sstream>

#pragma comment(lib, "iphlpapi.lib")

namespace {

const char kChannelName[] = "prepola.dev/flutter_ip_adapter_info";
const char kGetIpAdapterInfoMethod[] = "getIpAdapterInfo";

class FlutterIpAdapterInfoPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FlutterIpAdapterInfoPlugin();

  virtual ~FlutterIpAdapterInfoPlugin();

  std::vector<flutter::EncodableValue> getIpAdapterInfo();

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
  
  std::vector<flutter::EncodableValue> getIpAddrStrings(
      PIP_ADDR_STRING pIpAddrString);
};

// static
void FlutterIpAdapterInfoPlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows *registrar) {
  auto channel =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
          registrar->messenger(), kChannelName,
          &flutter::StandardMethodCodec::GetInstance());

  auto plugin = std::make_unique<FlutterIpAdapterInfoPlugin>();

  channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto &call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  registrar->AddPlugin(std::move(plugin));
}

FlutterIpAdapterInfoPlugin::FlutterIpAdapterInfoPlugin() {}

FlutterIpAdapterInfoPlugin::~FlutterIpAdapterInfoPlugin() {}

std::vector<flutter::EncodableValue> FlutterIpAdapterInfoPlugin::getIpAddrStrings(
  PIP_ADDR_STRING pIpAddrString){
  std::vector<flutter::EncodableValue> ipAddressList;
  while(pIpAddrString) {
    std::map<flutter::EncodableValue, flutter::EncodableValue> ipAddrString;
    ipAddrString.insert({flutter::EncodableValue("IpAddress"), flutter::EncodableValue(pIpAddrString->IpAddress.String)});
    ipAddrString.insert({flutter::EncodableValue("IpMask"), flutter::EncodableValue(pIpAddrString->IpMask.String)});
    ipAddressList.emplace_back(ipAddrString);

    pIpAddrString = pIpAddrString->Next;
  }
  return ipAddressList;
}

std::vector<flutter::EncodableValue> FlutterIpAdapterInfoPlugin::getIpAdapterInfo(){
  PIP_ADAPTER_INFO AdapterInfo;
  std::vector<flutter::EncodableValue> adapterInfos;
  DWORD dwBufLen = sizeof(IP_ADAPTER_INFO);

  AdapterInfo = (IP_ADAPTER_INFO *) malloc(sizeof(IP_ADAPTER_INFO));
  if (AdapterInfo == NULL) {
    printf("Error allocating memory needed to call GetAdaptersinfo\n");
    return adapterInfos;
  }

  if (GetAdaptersInfo(AdapterInfo, &dwBufLen) == ERROR_BUFFER_OVERFLOW) {
    free(AdapterInfo);
    AdapterInfo = (IP_ADAPTER_INFO *) malloc(dwBufLen);
    if (AdapterInfo == NULL) {
      printf("Error allocating memory needed to call GetAdaptersinfo\n");
      return adapterInfos;
    }
  }

  if (GetAdaptersInfo(AdapterInfo, &dwBufLen) == NO_ERROR) {
    PIP_ADAPTER_INFO pAdapterInfo = AdapterInfo;

    while(pAdapterInfo) {
      std::map<flutter::EncodableValue, flutter::EncodableValue> adapterInfo;

      adapterInfo.insert({flutter::EncodableValue("ComboIndex"), flutter::EncodableValue((int32_t) pAdapterInfo->ComboIndex)});

      adapterInfo.insert({flutter::EncodableValue("AdapterName"), flutter::EncodableValue(pAdapterInfo->AdapterName)});
      
      std::string description(pAdapterInfo->Description);
      adapterInfo.insert({flutter::EncodableValue("Description"), flutter::EncodableValue(description)});

      adapterInfo.insert({flutter::EncodableValue("AddressLength"), flutter::EncodableValue((int32_t) pAdapterInfo->AddressLength)});

      std::vector<BYTE> addressVector;
      addressVector.insert(addressVector.end(), pAdapterInfo->Address, pAdapterInfo->Address + sizeof(pAdapterInfo->Address));
      adapterInfo.insert({flutter::EncodableValue("Address"), flutter::EncodableValue(addressVector)});

      adapterInfo.insert({flutter::EncodableValue("Index"), flutter::EncodableValue((int32_t) pAdapterInfo->Index)});

      adapterInfo.insert({flutter::EncodableValue("Type"), flutter::EncodableValue((int32_t) pAdapterInfo->Type)});

      adapterInfo.insert({flutter::EncodableValue("DhcpEnabled"), flutter::EncodableValue((int32_t) pAdapterInfo->DhcpEnabled)});

      adapterInfo.insert({flutter::EncodableValue("IpAddressList"), flutter::EncodableValue(getIpAddrStrings(&pAdapterInfo->IpAddressList))});

      adapterInfo.insert({flutter::EncodableValue("GatewayList"), flutter::EncodableValue(getIpAddrStrings(&pAdapterInfo->GatewayList))});

      adapterInfo.insert({flutter::EncodableValue("DhcpServer"), flutter::EncodableValue(getIpAddrStrings(&pAdapterInfo->DhcpServer))});

      adapterInfo.insert({flutter::EncodableValue("HaveWins"), flutter::EncodableValue((bool) pAdapterInfo->HaveWins)});

      adapterInfo.insert({flutter::EncodableValue("PrimaryWinsServer"), flutter::EncodableValue(getIpAddrStrings(&pAdapterInfo->PrimaryWinsServer))});

      adapterInfo.insert({flutter::EncodableValue("SecondaryWinsServer"), flutter::EncodableValue(getIpAddrStrings(&pAdapterInfo->SecondaryWinsServer))});

      adapterInfo.insert({flutter::EncodableValue("LeaseObtained"), flutter::EncodableValue((int64_t) pAdapterInfo->LeaseObtained)});

      adapterInfo.insert({flutter::EncodableValue("LeaseExpires"), flutter::EncodableValue((int64_t) pAdapterInfo->LeaseExpires)});

      adapterInfos.emplace_back(adapterInfo);

      pAdapterInfo = pAdapterInfo->Next;
    };                        
  }
  free(AdapterInfo);
  return adapterInfos;
}

void FlutterIpAdapterInfoPlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue> &method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
  if (method_call.method_name().compare(kGetIpAdapterInfoMethod) == 0) {
    try {
		  result->Success(flutter::EncodableValue(getIpAdapterInfo()));
    } catch (...) {
      result->Success(flutter::EncodableValue());
    }
  } else {
    result->NotImplemented();
  }
}

}  // namespace

void FlutterIpAdapterInfoPluginRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  FlutterIpAdapterInfoPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
