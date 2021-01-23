import 'package:flutter/material.dart';

/// Text field styling. Check register/login screen
var kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: InputBorder.none,
  focusedBorder: InputBorder.none,
  enabledBorder: InputBorder.none,
  errorBorder: InputBorder.none,
  disabledBorder: InputBorder.none,
);

class ApiResponseKey {
  static String error = "error";
  static String data = "data";
}

const String API_BASE_URL = "http://galasejahtera.duckdns.org/";

const String GET_COVID_NEWS = "v1/covids";
const String CREATE_USER_ACCOUNT = "v1/users/0";
const String USER_LOGIN = "v1/login";
const String GET_CASE_BY_DISTRICT = "v1/places/";

const List<String> MALAYSIA_DISTRICTS = [
  "Klang",
  "Hulu Selangor",
  "Hulu Langat",
  "Petaling",
  "Sepang",
  "Gombak",
  "Kuala Langat",
  "Kuala Selangor",
  "Sabak Bernam",
  "Johor Bharu",
  "Muar",
  "Kulai",
  "Batu Pahat",
  "Kota Tinggi",
  "Kluang",
  "Pontian",
  "Mersing",
  "Segamat",
  "Tangkak",
  "Lembah Pantai",
  "Titiwangsa",
  "Kepong",
  "Cheras",
  "Kota Kinabalu",
  "Penampang",
  "Lahad Datu",
  "Tawau",
  "Sandakan",
  "Papar",
  "Putatan",
  "Keningau",
  "Kota Belud",
  "Kudat",
  "Tambunan",
  "Tuaran",
  "Kinabatangan",
  "Beaufort",
  "Sipitang",
  "Kunak",
  "Kalabakan",
  "Pitas",
  "Ranau",
  "Semporna",
  "Tenom",
  "Kota Marudu",
  "Beluran",
  "Kuala Penyu",
  "Telupid",
  "Tongod",
  "Nabawan",
  "Barat Daya",
  "Timur Laut",
  "Seberang Perai Selatan",
  "Seberang Perai Tengah",
  "Seberang Perai Utara",
  "Seremban",
  "Jelebu",
  "Port Dickson",
  "Tampin",
  "Rembau",
  "Jempol",
  "Kuala Pilah",
  "Kinta",
  "Larut, Matang, Selama",
  "Kerian",
  "Hilir Perak",
  "Manjung",
  "Batang Padang",
  "Kuala Kangsar",
  "Muallim",
  "Bagan Datuk",
  "Hulu Perak",
  "Kampar",
  "Perak Tengah",
  "Kota Bharu",
  "Tumpat",
  "Kuala Krai",
  "Bachok",
  "Machang",
  "Gua Musang",
  "Pasir Mas",
  "Pasir Puteh",
  "Tanah Merah",
  "Jeli",
  "Alor Gajah",
  "Melaka Tengah",
  "Alor Gajah",
  "Melaka Tengah",
  "Jasin",
  "Bentong",
  "Maran",
  "Kuantan",
  "Raub",
  "Rompin",
  "Bera",
  "Pekan",
  "Temerloh",
  "Cameron Highlands",
  "Jerantut",
  "Lipis",
  "Putrajaya",
  "Kota Setar",
  "Kuala Muda",
  "Kulim",
  "Baling",
  "Kubang Pasu",
  "Yan",
  "Pendang",
  "Sik",
  "Padang Terap",
  "Bandar Bahru",
  "Langkawi",
  "Labuan",
  "Sibu",
  "Kuching",
  "Miri",
  "Bintulu",
  "Meradong",
  "Kapit",
  "Sri Aman",
  "Kota Samarahan",
  "Lawas",
  "Selangau",
  "Asajaya",
  "Bau",
  "Daro",
  "Julau",
  "Lundu",
  "Matu",
  "Tanjung Manis",
  "Lubok Antu",
  "Tebedu",
  "Limbang",
  "Serian",
  "Sarikei",
  "Simunjan",
  "Mukah",
  "Betong",
  "Dungun",
  "Kuala Terengganu",
  "Besut",
  "Kuala Nerus",
  "Kemaman",
  "Marang",
  "Setiu",
  "Hulu Terengganu",
  "Perlis"
];
