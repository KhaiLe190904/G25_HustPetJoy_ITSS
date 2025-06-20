import React from "react";
import { assets } from "../assets/assets";

const Header = () => {
  return (
    <div className="flex flex-col md:flex-row flex-wrap bg-gradient-to-r from-blue-600 to-purple-600 rounded-lg px-6 md:px-10 lg:px-20 shadow-2xl">
      {/* --------- Header Left --------- */}
      <div className="md:w-1/2 flex flex-col items-start justify-center gap-4 py-10 m-auto md:py-[10vw] md:mb-[-30px]">
        <p className="text-3xl md:text-4xl lg:text-5xl text-white font-semibold leading-tight md:leading-tight lg:leading-tight">
          Đặt Lịch Hẹn <br /> Với Bác Sĩ Thú Y{" "}
          <span className="text-yellow-300">Uy Tín</span>
        </p>
        <div className="flex flex-col md:flex-row items-center gap-3 text-white text-sm font-light">
          <img className="w-28" src={assets.group_profiles} alt="" />
          <p>
            Dễ dàng duyệt qua danh sách các bác sĩ thú y uy tín,{" "}
            <br className="hidden sm:block" /> đặt lịch hẹn cho thú cưng yêu quý
            của bạn một cách nhanh chóng.
          </p>
        </div>
        <a
          href="#speciality"
          className="flex items-center gap-2 bg-white px-8 py-3 rounded-full text-gray-700 text-sm m-auto md:m-0 hover:scale-105 hover:shadow-lg transition-all duration-300 font-medium"
        >
          Đặt Lịch Hẹn Ngay{" "}
          <img className="w-3" src={assets.arrow_icon} alt="" />
        </a>
      </div>

      {/* --------- Header Right --------- */}
      <div className="md:w-1/2 relative">
        <img
          className="w-full md:absolute bottom-0 h-auto rounded-lg transform hover:scale-105 transition-transform duration-500"
          src={assets.header_img}
          alt="HustPetJoy Veterinary Care"
        />
      </div>
    </div>
  );
};

export default Header;
