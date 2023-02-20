import React from 'react'

const Feedback = () => {
  return (
    <div name='contact' className='w-full h-screen bg-[#46433f] flex justify-center items-center p-4'>
        <form method='POST' action="https://getform.io/f/7c79df37-3ded-4f63-bc73-4ca56e2cbb73" className='flex flex-col max-w-[600px] w-full'>
            <div className='pb-8'>
                <p className='text-4xl font-bold inline border-b-4 border-[#e11624] text-white'>Feedback</p>
                <p className='text-[#ffffff] py-4 text-xl'>Submit the form below or shoot me an email - mikeiannotti@mikeiannotti.com</p>
            </div>
            <input className='bg-[#ccd6f6] p-2' type="text" placeholder='Name' name='name'/>
            <input className='my-4 p-2 bg-[#ccd6f6]' type="text" placeholder='Email' name='email'/>
            <textarea className='bg-[#ccd6f6] p-2'  name='message' rows="10" placeholder='Message'></textarea>
            <button className='text-white border-2 hover:bg-[#e11624] hover:border-[#e11624] px-4 py-3 my-8 mx-auto items-center'>Send</button>
        </form>
    </div>
  )
}

export default Feedback