import React, { useState } from 'react';

export default function URIForm() {
  const [values, setValues] = useState({
    uri: '',
  });

  const handleInputChange = (event: React.FormEvent<HTMLFormElement>) => {
    event.persist()
    setValues((values) => ({
      ...values,
      [event.target.getAttribute('name')]: event.target.value
    }))
  }

  const handleSubmit = (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    const data = new FormData(event.currentTarget);
    console.log(data);
  };

  return (
    <section className="section is-large">
      <div className="container">
        <h1 className="title">Lynx: The URL Shortener</h1>
        <h2 className="subtitle"><em>a wild cat with yellowish-brown fur (sometimes spotted), a short tail, and tufted ears, found chiefly in the northern latitudes of North America and Eurasia.</em></h2>
        <form onSubmit={handleSubmit}>
          <div className="field">
            <label className="label">Enter a URL to shorten:</label>
          </div>
          <div className="field has-addons">
            <p className="control">
              <a className="button is-static is-large">
                https://
              </a>
            </p>
            <div className="control">
              <input
                className="input is-large"
                name="uri"
                type="text"
                placeholder="www.joshuamlee.com"
                value={values.uri}
                onChange={handleInputChange}
              />
            </div>
            <div className="control">
              <input type="submit" name="submit" value="Submit" className="button is-primary is-large" />
            </div>
          </div>
        </form>
      </div>
    </section>
  );
}
