/// 收敛数量单位
/// [amount] 0-9999=$amount  >9999=${0舍9入}万
String convergenceAmountUnit(int amount) {
  if (amount < 10000) {
    return amount.toString();
  }
  return "${((amount + 5000) / 10000.0).round()}万";
}
