import 'dart:io';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

// 애뮬레이터 로컬 IP
const emulatorIp = '10.0.2.2:3000';
// 시뮬레이터 로컬 IP
const simulatorIp = '10.10.100.26:3000';
// const simulatorIp = '127.0.0.1:3000';
// 로컬 IP
final ip = Platform.isIOS ? simulatorIp : emulatorIp;
